provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine            = "mysql"
  allocated_storage = 10
  instance_class    = "db.t2.micro"
  name              = "example_database"
  username          = "admin"
  password          = data.aws_secretmaanger_secret_version.db_password.secret_string
}

# Secret 데이터를 읽는 방법 1
# AWS 시크릿 매니저를 사용하는 방법
data "aws_secretmaanger_secret_version" "db_password" {
  secret_id = "mysql-master-password-stage"
}