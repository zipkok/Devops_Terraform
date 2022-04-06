provider "aws" {
  region = "ap-northeast-2"
}

terraform {
  backend "s3" {
    # 이전에 생성한 Bucket 이름으로 변경
    bucket = "woobeom-terraform-bucket"
    key    = "woob0914/infra/ap-northeast-2/mini/InfraSvc/terraform.tfstate"
    region = "ap-northeast-2"

    # 이전에 생성한 DynamoDB 테이블 이름으로 변경
    dynamodb_table = "woobeom-terraform-locks"
    encrypt        = true
  }
}


