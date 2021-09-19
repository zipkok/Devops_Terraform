provider "aws" {
  region = "us-east-2"
}

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