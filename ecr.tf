resource "aws_ecr_repository" "sporcello-repo" {
  count                = 0
  name                 = "sporcello"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "nginx-repo" {
  count                = 0
  name                 = "nginx"
  image_tag_mutability = "MUTABLE"
}
