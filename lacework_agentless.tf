module "lacework_aws_agentless_scanning_global" {
  #removing integration - will be managed via org integration
  count   = 0
  source  = "lacework/agentless-scanning/aws"
  version = "~> 0.3"

  global                    = true
  lacework_integration_name = "TF_agentless_sidekick"
}

module "lacework_aws_agentless_scanning_region" {
  #removing integration - will be managed via org integration
  count   = 0
  source  = "lacework/agentless-scanning/aws"
  version = ">= 0.3"

  regional                = true
  global_module_reference = module.lacework_aws_agentless_scanning_global
  #agentless_scan_ecs_task_role_arn      = module.lacework_aws_agentless_scanning_global.agentless_scan_ecs_task_role_arn
  #agentless_scan_ecs_execution_role_arn = module.lacework_aws_agentless_scanning_global.agentless_scan_ecs_execution_role_arn
  #agentless_scan_ecs_event_role_arn     = module.lacework_aws_agentless_scanning_global.agentless_scan_ecs_event_role_arn
  #agentless_scan_secret_arn             = module.lacework_aws_agentless_scanning_global.agentless_scan_secret_arn
  #lacework_account                      = module.lacework_aws_agentless_scanning_global.lacework_account
  #prefix                                = module.lacework_aws_agentless_scanning_global.prefix
  #suffix                                = module.lacework_aws_agentless_scanning_global.suffix
}
