module "lacework_aws_agentless_scanning_global" {
  source  = "lacework/agentless-scanning/aws"
  version = "~> 0.3"

  global                    = true
  lacework_integration_name = "sidekick_from_terraform"
}
