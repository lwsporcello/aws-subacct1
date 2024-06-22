data "aws_iam_policy_document" "ec2_instance_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com", ]
    }
  }

}

data "aws_iam_policy_document" "iam_policy_ec2_instance_document" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:*"]
    resources = ["*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "mongodb_instance_role" {
  name               = "ec2_instance_role"
  assume_role_policy = data.aws_iam_policy_document.ec2_instance_assume_role_policy.json
  inline_policy {
    name   = "mongodb-instance-role"
    policy = data.aws_iam_policy_document.iam_policy_ec2_instance_document.json
  }
}

resource "aws_iam_instance_profile" "mongodb_profile" {
  name = "mongodb-instance-profile"
  role = aws_iam_role.mongodb_instance_role.name
}
