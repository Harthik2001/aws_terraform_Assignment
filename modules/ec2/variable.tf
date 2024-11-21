# modules/ec2/variables.tf
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet"
  type        = string
}

variable "ssh_key_name" {
  description = "Name of the SSH key"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the instances"
  type        = string
  default     = "ami-012967cc5a8c9f891" # Amazon Linux 2
}

variable "instance_type" {
  description = "Instance type for VMs"
  type        = string
  default     = "t2.micro"
}