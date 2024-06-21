resource "aws_key_pair" "ssh_keypair" {
  key_name = "mongodb-keypair"
  public_key = file("./mongo.pub")
}
