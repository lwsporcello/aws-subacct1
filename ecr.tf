resource "aws_ecr_repository" "sporcello-repo" {
  name                 = "sporcello"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "nginx-repo" {
  name                 = "nginx"
  image_tag_mutability = "MUTABLE"
}
