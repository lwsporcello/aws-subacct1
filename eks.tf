locals {
  #resource names
  eks_cluster_name    = "sporcello-eks-cluster"
  eks_node_group_name = "sporcello-eks-ng"

  iam_cluster_role_name    = "sporcello-eks-cluster-role"
  iam_node_group_role_name = "sporcello-eks-nodegroup-role"

  cluster_security_group_name       = "sporcello-eks-cluster-sg"
  node_security_group_name          = "sporcello-eks-node-sg"
  control_plane_security_group_name = "sporcello-eks-controlplane-sg"

  enabled_log_types = ["audit"]
  version           = "1.28"

  eks_cluster_count = 1

  #auto scaling group
  desired_size   = 1
  max_size       = 1
  min_size       = 1
  instance_types = ["t3.medium"]

  admin-role-arn = "arn:aws:iam::626835103576:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_AWSAdministratorAccess_d852f39667487e5b"
  root_arn       = "arn:aws:iam::626835103576:root"
  tfc_role_arn   = "arn:aws:iam::626835103576:role/terraform-cloud-svc"
}

#create cluster with module
module "eks_cluster" {
  count  = local.eks_cluster_count
  source = "terraform-aws-modules/eks/aws"

  vpc_id       = aws_vpc.main.id
  subnet_ids   = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
  iam_role_arn = aws_iam_role.iam-role-eks-cluster.arn

  cluster_name                           = local.eks_cluster_name
  cluster_endpoint_private_access        = true
  cluster_endpoint_public_access         = true
  cluster_enabled_log_types              = local.enabled_log_types
  cluster_version                        = local.version
  cloudwatch_log_group_retention_in_days = 30

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  #kms config
  create_kms_key          = true
  enable_kms_key_rotation = true
  kms_key_administrators = [
    local.admin-role-arn,
    local.root_arn,
    local.tfc_role_arn
  ]

  #auth mode
  authentication_mode                      = "API_AND_CONFIG_MAP"
  enable_cluster_creator_admin_permissions = true

  create_cluster_security_group = true
  #cluster_security_group_name   = local.cluster_security_group_name
  #node_security_group_name      = local.node_security_group_name

  #create cluster security group
  cluster_security_group_additional_rules = {
    ingress_self = {
      type                       = "ingress"
      from_port                  = 0
      to_port                    = 0
      protocol                   = "-1"
      source_node_security_group = true
    }
    egress_all = {
      type        = "egress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  #create node security group
  node_security_group_additional_rules = {
    ingress_self = {
      type                          = "ingress"
      from_port                     = 0
      to_port                       = 0
      protocol                      = "-1"
      source_cluster_security_group = true
    }
    ingress_ssh = {
      type        = "ingress"
      from_port   = 0
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [var.my_ip]
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

#new node group resource block
resource "aws_eks_node_group" "eks-node-group-1" {
  cluster_name    = local.eks_cluster_name
  node_group_name = local.eks_node_group_name
  node_role_arn   = aws_iam_role.iam-role-eks-nodes.arn
  subnet_ids      = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]

  instance_types = local.instance_types
  capacity_type  = "ON_DEMAND"
  disk_size      = 20

  scaling_config {
    desired_size = local.desired_size
    max_size     = local.max_size
    min_size     = local.min_size
  }

  depends_on = [module.eks_cluster[0], aws_iam_role.iam-role-eks-nodes]
}

resource "aws_eks_access_entry" "admin-role" {
  cluster_name      = local.eks_cluster_name
  principal_arn     = local.admin-role-arn
  kubernetes_groups = ["system:nodes"]
  type              = "STANDARD"
}
