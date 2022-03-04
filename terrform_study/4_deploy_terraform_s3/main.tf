resource "aws_s3_bucket" "terraform_state" {
  bucket = "woobeom-up-and-running-state"

  # 실수로 S3 버킷을 삭제하는 것을 방지
  lifecycle {
    prevent_destroy = true
  }

  # 코드 이력을 관리하기 위해 상태 파일의 버전 관리를 활성화
// aws 모듈 버전을 업해야함. 기본 Enable로 바뀜
//   versioning {
//     enabled = true
//   }

  # 서버 측 암호화를 활성화
// aws 모듈 버전을 업해야함. 기본 Enable로 바뀜  
//   server_side_encryption_configuration {
//     rule {
//       apply_server_side_encryption_by_default {
//         sse_algorithm = "AES256"
//       }
//     }
//   }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "woobeom-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}