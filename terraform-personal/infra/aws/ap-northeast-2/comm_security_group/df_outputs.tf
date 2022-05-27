output "ec2_security_group_id" {
  value = module.ec2_security_group.security_group_id
}

output "alb_security_group_id" {
  value = module.alb_security_group.security_group_id
}
