resource "aws_instance" "ec2" {
  ami           = var.ec2_instance_config.ami
  instance_type = var.ec2_instance_config.instance_type

  vpc_security_group_ids = var.vpc_security_group_ids
  tags                   = var.ec2_instance_tags
  monitoring             = true

  root_block_device = {
    volume_size = var.ec2_instance_config.volume_size
  }
}