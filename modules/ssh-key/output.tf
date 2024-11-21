# modules/ssh-key/outputs.tf
output "key_name" {
  description = "Name of the generated SSH key"
  value       = aws_key_pair.deployer.key_name
}

output "private_key_pem" {
  description = "Private key in PEM format"
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}