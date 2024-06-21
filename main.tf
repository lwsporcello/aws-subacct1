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
    lacework = {
      source  = "lacework/lacework"
      version = "~> 1.0"
    }
  }
}

provider "lacework" {}

provider "aws" {
  region = "us-east-1"
}

#module "aws_config" {
#  source  = "lacework/config/aws"
#  version = "~> 0.5"
#}

#module "aws_cloudtrail" {
#  source                = "lacework/cloudtrail/aws"
#  version               = "~> 2.0"
#  use_existing_iam_role = true
#  iam_role_name         = module.aws_config.iam_role_name
#  iam_role_arn          = module.aws_config.iam_role_arn
#  iam_role_external_id  = module.aws_config.external_id
#}
