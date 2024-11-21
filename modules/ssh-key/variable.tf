# modules/ssh-key/variables.tf
variable "key_algorithm" {
  description = "The algorithm to use for the SSH key"
  type        = string
  default     = "RSA"
}

variable "key_rsa_bits" {
  description = "Number of bits in the RSA key"
  type        = number
  default     = 4096
}

variable "key_name_prefix" {
  description = "Prefix for the SSH key name"
  type        = string
  default     = "terraform-key"
}

variable "private_key_file_path" {
  description = "Path to save the private key file"
  type        = string
  default     = "./terraform_key.pem"
}