resource "aws_instance" "mdu_instanceTemplate" {
  for_each = toset(var.ec2_instance_name)

  ami                         = var.ec2_instance_info.ami
  instance_type               = var.ec2_instance_info.instance_type
  key_name                    = var.ec2_instance_info.key_name
  associate_public_ip_address = var.ec2_instance_info.associate_public_ip_address
  vpc_security_group_ids      = var.ec2_instance_security_groups
  subnet_id                   = element(var.vpc_ec2_subnet_id, tonumber(substr(each.value, -1, -1)) % 2)
  user_data                   = <<-EOF
                              #!/bin/bash
                              hostnamectl set-hostname ${each.value}
                              EOF

  tags = {
    Name         = each.value
    Creator      = var.ec2_instance_tags.Creator
    Team         = var.ec2_instance_tags.Team
    Project      = var.ec2_instance_tags.Project
    Service      = var.ec2_instance_tags.Service
    UseTerraform = "true"
  }

  root_block_device {
    volume_size           = var.ec2_root_volume.volume_size
    delete_on_termination = var.ec2_root_volume.delete_on_termination
    volume_type           = var.ec2_root_volume.volume_type
  }

  ebs_block_device {
    device_name           = "/dev/sdb"
    volume_size           = var.ec2_data_volume.volume_size
    delete_on_termination = var.ec2_data_volume.delete_on_termination
    volume_type           = var.ec2_data_volume.volume_type
  }
}
/* 
resource "aws_lb_target_group_attachment" "rsc_blog_alb_target_group_attachment" {
  count            = length(data.terraform_remote_state.instance_id.outputs.aws_instance_id)
  target_group_arn = aws_lb_target_group.rsc_blog_alb_target_group.arn
  target_id        = data.terraform_remote_state.instance_id.outputs.aws_instance_id[count.index]
  port             = 80
} */