# VPC 조회
data "aws_vpc" "default" {
  default = true
}

# =========================================================
# VPC 내 Subnet 조회
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

data "template_file" "user_data" {
  template = file("user-data.sh")

  vars = {
    server_port = var.server_port
    db_address  = data.terraform_remote_state.db.outputs.address
    db_port     = data.terraform_remote_state.db.outputs.port
  }
}
