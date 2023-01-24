#module "lacework_aws_agentless_scanning_global_2" {
#  source = "github.com/lwsporcello/terraform-aws-agentless-scanning"
#version = "~> 0.6"

#  global                          = true
#  regional                        = true
#  use_existing_cross_account_role = true
#  use_existing_event_role         = true
#  use_existing_execution_role     = true
#  use_existing_task_role          = true

#  cross_account_role_arn                = "arn:aws:iam::626835103576:role/lacework-ca-role"
#  external_id                           = "VON8ab7cfd0"
#  agentless_scan_ecs_task_role_arn      = "arn:aws:iam::626835103576:role/lacework-ecs-task-role"
#  agentless_scan_ecs_execution_role_arn = "arn:aws:iam::626835103576:role/lacework-ecs-execution-role"
#  agentless_scan_ecs_event_role_arn     = "arn:aws:iam::626835103576:role/lacework-ecs-event-role"

#  suffix                    = "sporcello0001"
#  lacework_integration_name = "TF agentless workload test"
#}

#single account single region example
#module "lacework_aws_agentless_scanning_3" {
#  source = "github.com/lwsporcello/terraform-aws-agentless-scanning"
#version = "~> 0.6"

#  global   = true
#  regional = true
#use_existing_iam_role       = true
#use_existing_event_role     = true
#use_existing_execution_role = true
#use_existing_task_role      = true

#iam_role_arn                          = "arn:aws:iam::626835103576:role/lacework-ca-role"
#external_id                           = "VON8ab7cfd0"
#agentless_scan_ecs_task_role_arn      = "arn:aws:iam::626835103576:role/lacework-ecs-task-role"
#agentless_scan_ecs_execution_role_arn = "arn:aws:iam::626835103576:role/lacework-ecs-execution-role"
#agentless_scan_ecs_event_role_arn     = "arn:aws:iam::626835103576:role/lacework-ecs-event-role"

#suffix                    = "sporcello0002"
#  lacework_integration_name = "TF agentless workload test2"
#}

#single account multi region example
#provider "aws" {
#  alias  = "usw2"
#  region = "us-west-2"
#}
#module "lacework_aws_agentless_scanning_global" {
#  source                                = "github.com/lwsporcello/terraform-aws-agentless-scanning"
#  global                                = true
#  lacework_integration_name             = "TF agentless workload test2"
#  use_existing_cross_account_role       = true
#  use_existing_event_role               = true
#  use_existing_execution_role           = true
#  use_existing_task_role                = true
#  cross_account_role_arn                = "arn:aws:iam::626835103576:role/lacework-ca-role"
#  external_id                           = "VON8ab7cfd0"
#  agentless_scan_ecs_task_role_arn      = "arn:aws:iam::626835103576:role/lacework-ecs-task-role"
#  agentless_scan_ecs_execution_role_arn = "arn:aws:iam::626835103576:role/lacework-ecs-execution-role"
#  agentless_scan_ecs_event_role_arn     = "arn:aws:iam::626835103576:role/lacework-ecs-event-role"
#  suffix                                = "sporcello0003"
#}
#module "lacework_aws_agentless_scanning_regional_1" {
#  source                    = "github.com/lwsporcello/terraform-aws-agentless-scanning"
#  regional                  = true
#  global_module_reference   = module.lacework_aws_agentless_scanning_global
#}
#module "lacework_aws_agentless_scanning_regional_2" {
#  source                    = "github.com/lwsporcello/terraform-aws-agentless-scanning"
#  regional                  = true
#  global_module_reference   = module.lacework_aws_agentless_scanning_global
#  providers = {
#    aws = aws.usw2
#  }
#}
