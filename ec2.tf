resource "aws_instance" "rhel6" {
  count         = 0
  ami           = "ami-0729e439b6769d6ab"
  instance_type = "t2.small"

  tags = {
    Name = "ubuntu18.04"
  }
}
