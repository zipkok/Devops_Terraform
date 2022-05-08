output "aws_instance_id" {
    description = "Instance ID"
    value = module.blog-webapp.oup_aws_instance_id[0]
}

// output "aws_instance_id" {
//   value = [ for vpc in module.blog-webapp.oup_aws_instance_id[*] : vpc ]
// }