# main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "networking" {
  source = "./modules/networking"
  
  vpc_cidr         = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zones = var.availability_zones
}

module "ssh_key" {
   source = "./modules/ssh-key"
  
  key_algorithm    = "RSA"
  key_rsa_bits     = 2048  # Optional: use smaller key if needed
  key_name_prefix  = "my-project-key"
  private_key_file_path = "${path.module}/keys/my_private_key.pem"
}

module "ec2" {
  source = "./modules/ec2"
  
  vpc_id            = module.networking.vpc_id
  public_subnet_id  = module.networking.public_subnet_id
  private_subnet_id = module.networking.private_subnet_id
  ssh_key_name      = module.ssh_key.key_name
}