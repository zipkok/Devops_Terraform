output "oup_aws_instance" {
  value = aws_instance.mdu_instanceTemplate[*]
}