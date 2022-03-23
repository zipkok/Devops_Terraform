provider "aws" {
  region     = "ap-northeast-2"
  secret_key = "Lyc+0vAZ1TKV1pWuBccJ6205/ejfCB1kasd/4/xh"
  access_key = "AKIAV7BJOATBFQ77OPLU"
}

resource "aws_s3_bucket" "backend_bucket" {
  bucket = "terraform-woobeom-bucket"
}

resource "aws_dynamodb_table" "backend_locks" {
  name         = "terraform-woobeom-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}