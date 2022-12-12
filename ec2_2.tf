resource "aws_instance" "ubuntu16" {
  ami           = "ami-0b0ea68c435eb488d"
  instance_type = "t2.small"

  tags = {
    Name = "ubuntu16.04"
  }
}
