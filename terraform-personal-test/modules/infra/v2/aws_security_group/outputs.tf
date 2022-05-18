output "security_group_id" {
  value = [ for value in aws_security_group.security_group : value.id ]
}

output "security_group_arn" {
  value = [ for value in aws_security_group.security_group : value.arn ]
}

output "security_group_owner_id" {
  value = [ for value in aws_security_group.security_group : value.owner_id ]
}