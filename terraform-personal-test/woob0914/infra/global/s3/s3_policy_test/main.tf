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

  ignore_public_acls      = false
  restrict_public_buckets = false
  block_public_acls       = false
  block_public_policy     = false
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.example.json
}

data "aws_iam_policy_document" "example" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    sid       = "UniqueSidOne"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::woobeom-test-bucket/*", "arn:aws:s3:::woobeom-test-bucket"]
    effect    = "Allow"
  }
}