variable "region" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}


variable "instance_type" {
  type = string
}

variable "ports" {
  type = list(number)
}

variable "instance_name" {
  type = string
}


variable "ami_image_name" {
  type = string
}