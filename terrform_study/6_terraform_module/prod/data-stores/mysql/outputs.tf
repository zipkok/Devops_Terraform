output "address" {
  value       = aws_db_instance.example.address
  description = "Connect to the database at this endPoint"
}

output "port" {
  value       = aws_db_instance.example.port
  description = "The Port the database is listening on"
}