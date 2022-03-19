// 오픈할 tfstate
data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = "woobeom-up-and-running-state"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "ap-northeast-2"
  }
}