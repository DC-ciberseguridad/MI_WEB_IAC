variable "aws_region" {
  default = "us-east-1"
}

variable "ssh_public_key" {
  description = "SSH public key for EC2"
  type        = string
}

variable "ssh_ip" {
  description = "IP allowed to SSH (x.x.x.x/32)"
  type        = string
}