terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    lacework = {
      source  = "lacework/lacework"
      version = "~> 0.14.0"
    }
  }
}

provider "lacework" {}

provider "aws" {
  region  = "us-east-1"
  profile = "test123"
}

