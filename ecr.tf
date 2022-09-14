resource "aws_ecr_repository" "sporcello-ecr-subacct" {
  name                 = "tf-sporcello-ecr-subacct"
  image_tag_mutability = "MUTABLE"
}
