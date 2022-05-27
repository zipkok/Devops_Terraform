provider "aws" {
  region = "ap-northeast-2"
}

terraform {
  backend "s3" {
    # 이전에 생성한 Bucket 이름으로 변경
    key            = "infra/aws/ap-northeast-2/blog/webapp_ec2_instance/terraform.tfstate"
    bucket         = "woobeom-terraform-bucket"
    dynamodb_table = "woobeom-terraform-locks"
    region         = "ap-northeast-2"
    encrypt        = true
  }
}
