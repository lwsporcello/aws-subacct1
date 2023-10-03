module "aws_config" {
  source                    = "lacework/config/aws"
  version                   = "~> 0.7"
  lacework_integration_name = "TF-config-sub1"
}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 2.3"

  bucket_force_destroy      = true
  use_existing_iam_role     = true
  iam_role_name             = module.aws_config.iam_role_name
  iam_role_arn              = module.aws_config.iam_role_arn
  iam_role_external_id      = module.aws_config.external_id
  lacework_integration_name = "TF-config-sub1"
}
