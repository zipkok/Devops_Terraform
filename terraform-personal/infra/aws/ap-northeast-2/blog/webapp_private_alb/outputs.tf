// terraform_remote_state로 오픈.
data "terraform_remote_state" "instance_id" {
  backend = "s3"

  config = {
    bucket = "woobeom-terraform-bucket"
    key    = "woob0914/infra/ap-northeast-2/blog/webapp/terraform.tfstate"
    region = "ap-northeast-2"
  }
}