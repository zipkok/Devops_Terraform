provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "woobeom-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

// Permissions - Block Public Access
resource "aws_s3_bucket_public_access_block" "bucket_access" {
  bucket = aws_s3_bucket.bucket.id

  ignore_public_acls      = true
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {}
    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::woobeom-test-bucket"]
    effect    = "Allow"
  }
}