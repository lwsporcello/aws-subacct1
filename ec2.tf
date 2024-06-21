resource "aws_key_pair" "ssh_keypair" {
  key_name = "mongodb-keypair"
  public_key = file("~/.ssh/mongo.pub")
}
