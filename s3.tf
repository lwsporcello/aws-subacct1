resource "aws_s3_bucket" "mongodb-backup" {
  bucket = "mongodb-backup-sporcello"
  tags = {
    Name = "MongoDB Backup"
  }
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "mongodb-backup" {
  bucket = aws_s3_bucket.mongodb-backup.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "mongodb-backup" {
  bucket = aws_s3_bucket.mongodb-backup.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "mongodb-backup" {
  depends_on = [
    aws_s3_bucket_ownership_controls.mongodb-backup,
    aws_s3_bucket_public_access_block.mongodb-backup,
  ]

  bucket = aws_s3_bucket.mongodb-backup.id
  acl    = "public-read"
}

data "aws_iam_policy_document" "s3_read_permissions" {
  statement {
    effect = "Allow"
    actions = ["s3:*"]
    resources = [aws_s3_bucket.mongodb-backup.id]
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.mongodb-backup.id
  policy = data.aws_iam_policy_document.s3_read_permissions
}
