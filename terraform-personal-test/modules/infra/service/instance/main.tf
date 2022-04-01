resource "aws_instance" "ec2" {
  ami                    = var.ec2_instance_config.ami
  instance_type          = var.ec2_instance_config.instance_type
  volume_size            = var.ec2_instance_config.volume_size
  vpc_security_group_ids = ["sg-12345678"]
  tags                   = var.ec2_instance_tags
  monitoring             = true
}