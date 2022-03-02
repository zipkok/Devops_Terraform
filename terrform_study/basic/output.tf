output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP Address of the web Server"
}