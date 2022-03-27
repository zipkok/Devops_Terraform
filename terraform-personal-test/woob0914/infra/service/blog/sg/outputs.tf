output "address" {
  value       = aws_security_group.module.blog-frontend
  description = "Connect to the database at this endPoint"
}