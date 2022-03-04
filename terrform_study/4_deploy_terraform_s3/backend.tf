// terraform {
//   backend "local" {
//   }
// }

terraform {
  backend "s3" {
    # 이전에 생성한 Bucket 이름으로 변경
    bucket = "terraofmr-up-and-running-state"
    key    = "global/s3/terraform.tfstate"
    region = "ap-northeast-2"

    # 이전에 생성한 DynamoDB 테이블 이름으로 변경
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}