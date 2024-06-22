resource "aws_key_pair" "ssh_keypair" {
  key_name   = "mongodb-keypair"
  public_key = file("./mongo.pub")
}

resource "aws_instance" "mongodb_instance" {
  count                       = 1
  ami                         = "ami-0fc5d935ebf8bc3bc" # Ubuntu 20.04 LTS
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.ssh_keypair.key_name
  subnet_id                   = aws_subnet.public-subnet.id
  security_groups             = [aws_security_group.db-sg.id]
  associate_public_ip_address = true
  user_data                   = filebase64("./mongodb_startup.sh")
  user_data_replace_on_change = true
  iam_instance_profile        = aws_iam_instance_profile.mongodb_profile.name
  tags = {
    Name = "mongodb server"

  }
}
