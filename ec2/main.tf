provider "aws" {
  region = "us-east-2"
}

/* resource "aws_instance" "example" {
  count                       = 2
  ami                         = "ami-00399ec92321828f5"
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  vpc_security_group_ids      = data.aws_security_groups.get_security_group.ids

  tags = {
    Name    = "terraform-example",
    woobeom = "woobeom",
    im      = "im"
  }
} */

module "example1" {
  source        = "../modules/ec2"
  instance_type = "t2.micro"
  server_count  = 1

  volume_size = 16

  tag_name    = "example1"
  tag_woobeom = "server1"
  tag_im      = "im"
}

module "example2" {
  source        = "../modules/ec2"
  instance_type = "t2.micro"
  server_count  = 1

  volume_size = 8

  tag_name    = "example2"
  tag_woobeom = "server2"
  tag_im      = "im"
}