resource "aws_instance" "rhel6" {
  ami           = "ami-04bb0cdc5b687d9e4"
  instance_type = "t2.small"

  tags = {
    Name = "rhel6"
  }
}
