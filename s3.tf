resource "aws_s3_bucket" "mongodb-backup" {
  bucket = "mongodb-backup"
  tags = {
    Name = "MongoDB Backup"
  }
  force_destroy = true
}
