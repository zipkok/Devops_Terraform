resource "aws_instance" "mdu_instanceTemplate" {
  for_each = toset(var.ec2_instance_name)

  ami                         = var.ec2_instance_info.ami
  instance_type               = var.ec2_instance_info.instance_type
  vpc_security_group_ids      = var.ec2_instance_security_group
  key_name                    = var.ec2_instance_info.key_name
  associate_public_ip_address = true

  subnet_id = var.vpc_ec2_subnet_id

  user_data = <<-EOF
            #!/bin/bash
            hostnamectl set-hostname ${each.value}
            EOF

  tags = {
    Name         = each.value
    Creator      = var.ec2_instance_tags.creator
    Team         = var.ec2_instance_tags.team
    Project      = var.ec2_instance_tags.project
    Service      = var.ec2_instance_tags.service
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