# https://honglab.tistory.com/216
# id들만 list로 뽑기
output "aws_instance_id_1" {
  value = [ for hostname in module.blog-webapp.oup_aws_instance[0] : hostname.id ]
  description = "module.<module을 사용한 tf NAME>.<module_output 정보>"
}

# key값을 사용해 map으로 뽑기
output "aws_instance_id_2" {
  value = { for k, hostname in module.blog-webapp.oup_aws_instance[0] : k => hostname.id }
}