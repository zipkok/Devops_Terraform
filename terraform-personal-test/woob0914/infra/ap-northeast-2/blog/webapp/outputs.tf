output "aws_instance_id" {
    description = "Instance ID"
    value = module.blog-webapp[*]
}