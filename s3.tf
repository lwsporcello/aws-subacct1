resource "aws_s3_bucket" "mongodb-backup" {
  bucket = "mongodb-backup-sporcello"
  tags = {
    Name = "MongoDB Backup"
  }
  force_destroy = true
}
