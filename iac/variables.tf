variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "Ubuntu 22.04 AMI"
}

variable "public_key_path" {
  description = "Path to SSH public key"
}

variable "ssh_ip" {
  description = "Your IP /32"
}
