output "aws_instance_id" {
    description = "Instance ID"
    value = module.aws_instance.blog-webapp.id

}