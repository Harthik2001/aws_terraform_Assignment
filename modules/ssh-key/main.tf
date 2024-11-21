resource "tls_private_key" "ssh_key" {
  algorithm = var.key_algorithm
  rsa_bits  = var.key_rsa_bits
}

resource "aws_key_pair" "deployer" {
  key_name   = "${var.key_name_prefix}-${random_id.key_suffix.hex}"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "random_id" "key_suffix" {
  byte_length = 4
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = var.private_key_file_path
  file_permission = "0400"
}