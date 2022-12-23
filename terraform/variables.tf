variable "environment" {
  type   = string
  default = "dev"
}

variable "instance_type" {
  type    = string
  default = "t2-micro"
}

variable "key_name" {
  type = string
}

variable "owner" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "server_name" {
  type = string
}
