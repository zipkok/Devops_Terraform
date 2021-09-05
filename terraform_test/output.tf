output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The Public IP address of the web server"
}

output "alb_dns" {
  value       = aws_lb.example.dns_name
  description = "The alb_dns of the ALB"
}

output "vpc_subnet" {
  value       = data.aws_subnet_ids.default.ids
  description = "The Subnet Ids"
}
