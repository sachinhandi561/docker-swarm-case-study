variable "aws_region" {
  description = "AWS region on which we will setup the swarm cluster"
  default = "ap-south-1"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default = "ami-0620d12a9cf777c87"
}

variable "instance_type" {
  description = "Instance type"
  default = "t2.micro"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "~/.ssh/id_rsa.pub"
}

variable "bootstrap_path" {
  description = "Script to install Docker Engine"
  default = "install-docker.sh"
}
variable "my_public_subnets" {
  description = "add your subnets here"
  type    = "list"
  default = ["subnet-66dcc21e", "subnet-6936d600", "subnet-ca745980"]
}
