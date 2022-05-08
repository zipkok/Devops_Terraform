// output "aws_instance_id" {
//     description = "Instance ID"
//     value = module.blog-webapp.oup_aws_instance_id[*].*.arn
// }

output "aws_instance_id" {
  value = { for k,vpc in module.blog-webapp.oup_aws_instance_id[*] : k => vpc.id }
}