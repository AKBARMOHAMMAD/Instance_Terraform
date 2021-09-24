variable "region" {
  default="us-east-1"
  description = "AWS Region"
  type = string
}

variable "access_key" {
  default= "AKIAWOJIJY26TTPV4JGI"
  description = "AWS Access key"
  type = string
}

variable "secret_key" {
  default="CnPv0OHmo6aqmS4M35hwdiKt/+rARs5AjkSYqPQh"
  description = "AWS Secret key"
  type = string
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
  description = "AWS VPC CIDR BLOCK"
  type = string
}

variable "subnet1_cidr_block" {
  default = "10.0.0.0/24"
  description = "AWS PUBLIC SUBNET1 CIDR BLOCK"
  type = string
}

variable "subnet2_cidr_block" {
  default = "10.0.1.0/24"
  description = "AWS PUBLIC SUBNET2 CIDR BLOCK"
  type = string
}

variable "ami" {
  default = "ami-087c17d1fe0178315"
  description = "AMI of AMAZON LINUX SERVER"
  type = string
}
