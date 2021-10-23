provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    # 생성한 버킷 이름으로 변경
    bucket = "woobeom-state"
    #key    = "global/s3/terraform.tfstate"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"

    # 생성한 다이나모DB 테이블 이름으로 변경
    dynamodb_table = "woobeom-state-locks"
    encrypt        = true
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine            = "mysql"
  allocated_storage = 10
  instance_class    = "db.t2.micro"
  name              = "example_database"
  username          = "admin"
  password          = var.db_password
  # password          = data.aws_secretmaanger_secret_version.db_password.secret_string

}

# Secret 데이터를 읽는 방법 1
# AWS 시크릿 매니저를 사용하는 방법
/* data "aws_secretmaanger_secret_version" "db_password" {
  secret_id = "mysql-master-password-stage"
} */


# Secret 데이터를 읽는 방법 2 
# export TF_VAR_db_password