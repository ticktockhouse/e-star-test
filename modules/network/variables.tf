variable "public_subnet_newbits" {
  type = number
  description = "The number of newbits for the public subnet"
}

variable "private_subnet_newbits" {
  type = number
  description = "The number of newbits for the private subnet"
}

variable "region" {
  type = string
  description = "Region that the VPCs will be created in"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR block of the VPC"
}