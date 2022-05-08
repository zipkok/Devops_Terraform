output "aws_instance_id" {
    description = "Instance ID"
    value = module.blog-webapp.oup_aws_instance_id[0]
}

output "aws_instance_id" {
  value = [ for hostname in module.blog-webapp.oup_aws_instance_id[0] : hostname.id ]
}