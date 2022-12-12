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


#USE BELOW, NOT ABOVE

#Org integration - global resources, scanning resources
#module "lacework_aws_agentless_scanning_global" {
#  source  = "lacework/agentless-scanning/aws"
#  version = "~> 0.6"

#  global = true
#  organization = {
#    monitored_accounts = ["975442149240", "626835103576", "153466455358"]
#    management_account = "975442149240"
#  }

#  lacework_integration_name = "TF agentless workload org"
#}

#module "lacework_aws_agentless_scanning_region" {
#  source  = "lacework/agentless-scanning/aws"
#  version = "~> 0.6"

#  regional                = true
#  global_module_reference = module.lacework_aws_agentless_scanning_global
#  vpc_cidr_block          = "10.10.34.0/24"
#}
