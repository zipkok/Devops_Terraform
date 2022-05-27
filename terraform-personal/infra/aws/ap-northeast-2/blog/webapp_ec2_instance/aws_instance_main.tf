module "blog_webapp" {
  source = "../../../../../modules/aws/v2/aws_instance"

  # Using a remote_state
  ec2_instance_security_group = var.security_groups

  # Using a .tfvars
  ec2_instance_name = var.ec2_name_tag
  ec2_instance_tags = var.common_ec2_tags
  vpc_ec2_subnet_id = var.subnet_ids
  ec2_instance_info = {
    ami                         = var.ec2_name_config.ami
    instance_type               = var.ec2_name_config.instance_type
    key_name                    = var.ec2_name_config.key_name
    associate_public_ip_address = var.ec2_name_config.associate_public_ip_address
  }

  ec2_root_volume = {
    volume_size           = var.ec2_name_config.ec2_root_volume
    delete_on_termination = true
    volume_type           = "gp3"
  }

  ec2_data_volume = {
    volume_size           = var.ec2_name_config.ec2_data_volume
    delete_on_termination = true
    volume_type           = "gp3"
  }
}


resource "aws_eip" "lb" {
  count    = length([for hostname in module.blog_webapp.oup_aws_instance[0] : hostname.id])
  instance = [for hostname in module.blog_webapp.oup_aws_instance[0] : hostname.id][count.index]
  vpc      = true
  tags     = var.common_ec2_tags
}
