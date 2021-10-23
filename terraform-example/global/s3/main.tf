provider "aws" {
  region = "us-east-1"
}

/* terraform {
  backend "s3" {
    # 생성한 버킷 이름으로 변경
    bucket = "woobeom-state"
    #key    = "global/s3/terraform.tfstate"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"

    # 생성한 다이나모DB 테이블 이름으로 변경
    dynamodb_table = "woobeom-state-locks"
    encrypt        = true
  }
} */

resource "aws_s3_bucket" "terraform_state" {
  bucket = "woobeom-state"

  # 실수로 S3를 삭제하는 것을 방지
  #lifecycle {
  #  prevent_destroy = true
  #}

  # 상태 파일의 버전 관리를 활성화
  versioning {
    enabled = true
  }

  # 서버 측 암호화를 활성화
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "woobeom-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}