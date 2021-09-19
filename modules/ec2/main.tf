provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami                         = "ami-00399ec92321828f5"
  instance_type               = var.instance_type
  count                       = var.server_count
  associate_public_ip_address = false
  vpc_security_group_ids      = data.aws_security_groups.get_security_group.ids

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = var.volume_size

    tags = {
      Name    = var.tag_name
      woobeom = var.tag_woobeom
      im      = var.tag_im
    }
  }

  tags = {
    Name    = var.tag_name
    woobeom = var.tag_woobeom
    im      = var.tag_im
  }
}
