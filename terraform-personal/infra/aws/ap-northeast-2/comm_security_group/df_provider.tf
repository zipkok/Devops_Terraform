provider "aws" {
  region = "ap-northeast-2"
}

terraform {
  backend "s3" {
    key            = "infra/aws/ap-northeast-2/comm_security_group/terraform.tfstate"
    bucket         = "woobeom-terraform-bucket"
    dynamodb_table = "woobeom-terraform-locks"
    region         = "ap-northeast-2"
    encrypt        = true
  }
}
