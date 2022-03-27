output "address" {
  value       = module.blog-frontend.aws_security_group.security_group
  description = "Connect to the database at this endPoint"
}