module "blog_webapp" {
  # source = "../../../../../modules/aws/v2/aws_instance"
  # source = "../../../../../modules/aws/v2/aws_instance_with_eip"
  source = "../../../../../modules/aws/v2/aws_instance_with_alb"

  # Using a remote_state
  ec2_instance_security_groups = [
    "${data.terraform_remote_state.security_group_id.outputs.default_security_group_id[0]}",
    "${data.terraform_remote_state.security_group_id.outputs.ec2_security_group_id[0]}",
  ]

  # Configuring EC2 with .tfvars
  ec2_instance_name = var.ec2_name_tag
  ec2_instance_tags = var.common_ec2_tags
  vpc_ec2_subnet_id = var.subnet_ids
  ec2_instance_info = {
    ami                         = var.ec2_instance_config.ami
    instance_type               = var.ec2_instance_config.instance_type
    key_name                    = var.ec2_instance_config.key_name
    associate_public_ip_address = var.ec2_instance_config.associate_public_ip_address
  }

  ec2_root_volume = {
    volume_size           = var.ec2_instance_config.ec2_root_volume
    delete_on_termination = true
    volume_type           = "gp3"
  }

  ec2_data_volume = {
    volume_size           = var.ec2_instance_config.ec2_data_volume
    delete_on_termination = true
    volume_type           = "gp3"
  }

  # Configuring ALB with .tfvars
  alb_lb_info = var.alb_lb_config
  alb_security_groups = var.alb_lb_security_groups
  vpc_id = var.vpc_id
}