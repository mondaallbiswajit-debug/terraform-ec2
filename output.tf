output "elastic_ip" {
  description = "static public ip of the instance, point your domain A record here"
  value       = aws_eip.elastic_ip.public_ip
}

output "instance_id" {
  value = aws_instance.example.id
}
