data "aws_security_groups" "get_security_group" {
  tags = {
    Name = "woobeom"
  }
}

output "stdout_get_security_group" {
  value = data.aws_security_groups.get_security_group.ids
}