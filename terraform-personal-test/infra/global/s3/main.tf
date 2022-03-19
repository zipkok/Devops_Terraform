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