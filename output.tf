# outputs.tf
output "public_vm_ip" {
  description = "Public IP of the public VM"
  value       = module.ec2.public_vm_ip
}

output "private_vm_ip" {
  description = "Private IP of the private VM"
  value       = module.ec2.private_vm_ip
}

output "ssh_key_name" {
  description = "Name of the generated SSH key"
  value       = module.ssh_key.key_name
}