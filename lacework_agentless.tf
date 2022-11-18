#removing integration - will be managed via org integration
#module "lacework_aws_agentless_scanning_global" {
#  source  = "lacework/agentless-scanning/aws"
#  version = "~> 0.3"

#  global                    = true
#  lacework_integration_name = "TF_agentless_sidekick"
#}

#removing integration - will be managed via org integration
#module "lacework_aws_agentless_scanning_region" {
#  source  = "lacework/agentless-scanning/aws"
#  version = ">= 0.3"

#  regional                = true
#  global_module_reference = module.lacework_aws_agentless_scanning_global
#}
