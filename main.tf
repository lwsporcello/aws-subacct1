terraform {
  backend "remote" {
    organization = "sporcello"
    workspaces {
      name = "aws-subacct1"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

#provider "kubernetes" {
#  host                   = data.aws_eks_cluster.cluster[0].endpoint
#  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster[0].certificate_authority.0.data)

#  exec {
#    api_version = "client.authentication.k8s.io/v1beta1"
#    args        = ["eks", "get-token", "--cluster-name", local.eks_cluster_name, "--region", var.AWS_REGION]
#    command     = "aws"
#  }
#}
