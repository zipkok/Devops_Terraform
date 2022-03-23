provider "aws" {
  region  = "ap-northeast-2"
  version = "~> 3.0"
}

resource "aws_s3_bucket" "backend_bucket" {
  bucket = "woobeom-terraform-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "backend_locks" {
  name         = "woobeom-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}