output "alb_arn" {
  description = "Outputs ALB ARN"
  value       = aws_lb.rsc_aws_alb.arn
}

output "dns_name" {
  description = "Outputs ALB DNS name"
  value       = aws_lb.rsc_aws_alb.dns_name
}