#single account multi region example
provider "aws" {
  alias  = "usw2"
  region = "us-west-2"
}

module "lacework_aws_agentless_scanning_global" {
  source  = "lacework/agentless-scanning/aws"
  version = "~> 0.5"

  global                    = true
  regional                  = true
  lacework_integration_name = "TF-agentless-sub1"
}
