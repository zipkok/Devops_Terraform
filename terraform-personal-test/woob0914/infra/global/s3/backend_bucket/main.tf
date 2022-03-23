resource "aws_s3_bucket" "backend_bucket" {
  bucket = "woobeom-terraform-bucket"

  # 실수로 S3 버킷을 삭제하는 것을 방지
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "woobeom-terraform-bucket"
    Environment = "Dev"
    Description = "Terraform tfstate Bucket"
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