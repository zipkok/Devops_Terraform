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
    principals {
      type        = "AWS"
      identifiers = ["123456789012"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}