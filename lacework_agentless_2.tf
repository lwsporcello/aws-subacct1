module "lacework_aws_agentless_scanning_global_2" {
  source = "github.com/lwsporcello/terraform-aws-agentless-scanning-test"
  #version = "~> 0.6"

  global                      = true
  regional                    = true
  use_existing_iam_role       = true
  use_existing_event_role     = true
  use_existing_execution_role = true
  use_existing_task_role      = true

  iam_role_arn                          = "arn:aws:iam::626835103576:role/lacework-ca-role"
  iam_role_external_id                  = "VON8ab7cfd0"
  agentless_scan_ecs_task_role_arn      = "arn:aws:iam::626835103576:role/lacework-ecs-task-role"
  agentless_scan_ecs_execution_role_arn = "arn:aws:iam::626835103576:role/lacework-ecs-execution-role"
  agentless_scan_ecs_event_role_arn     = "arn:aws:iam::626835103576:role/lacework-ecs-event-role"

  suffix                    = "sporcello5678"
  lacework_integration_name = "TF agentless workload test"
}
