#Mongo DB IAM
data "aws_iam_policy_document" "ec2_instance_assume_role_policy" {
  count = 0
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com", ]
    }
  }

}

data "aws_iam_policy_document" "iam_policy_ec2_instance_document" {
  count = 0
  statement {
    effect    = "Allow"
    actions   = ["ec2:*"]
    resources = ["*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "mongodb_instance_role" {
  count              = 0
  name               = "ec2_instance_role"
  assume_role_policy = data.aws_iam_policy_document.ec2_instance_assume_role_policy[0].json
  inline_policy {
    name   = "mongodb-instance-role"
    policy = data.aws_iam_policy_document.iam_policy_ec2_instance_document[0].json
  }
}

resource "aws_iam_instance_profile" "mongodb_profile" {
  count = 0
  name  = "mongodb-instance-profile"
  role  = aws_iam_role.mongodb_instance_role[0].name
}

#EKS IAM
#create IAM role for cluster
resource "aws_iam_role" "iam-role-eks-cluster" {
  count              = 0
  name               = local.iam_cluster_role_name
  assume_role_policy = <<POLICY
{
 "Version": "2012-10-17",
 "Statement": [
   {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
   }
  ]
 }
POLICY
}

#create IAM role for node group
resource "aws_iam_role" "iam-role-eks-nodes" {
  count              = 0
  name               = local.iam_node_group_role_name
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

#attach policies to cluster role
resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSClusterPolicy" {
  count      = 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam-role-eks-cluster[0].name
}

#attach policies to ng role
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  count      = 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.iam-role-eks-nodes[0].name
}
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  count      = 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.iam-role-eks-nodes[0].name
}
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  count      = 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.iam-role-eks-nodes[0].name
}
