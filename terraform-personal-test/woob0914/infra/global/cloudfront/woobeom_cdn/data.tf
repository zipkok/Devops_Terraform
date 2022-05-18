// terraform_remote_state 읽기
data "terraform_remote_state" "static_bucket_name" {
  backend = "s3"

  config = {
    bucket = "woobeom-terraform-bucket"
    key    = "woob0914/infra/ap-northeast-2/blog/s3/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
