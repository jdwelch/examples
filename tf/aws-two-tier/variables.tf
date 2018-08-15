variable "region" {
  default = "eu-west-1"
}

variable "key_name" {
  default = "pl-ux-common"
}

variable "ami" {
  default = "ami-f90a4880" # Ubuntu Server 16.04 LTS (HVM), SSD Volume Type in eu-west-1
}

variable "instance_type" {
  default = "t2.nano"
}

variable "instance_count" {
  default = 3
}

variable "tag_created_by" {
  default = "mein.name@example.com"
}

variable "tag_dept" {
  default = "engineering"
}

variable "tag_project" {
  default = "incubation"
}

variable "tag_lifetime" {
  default = "12h"
}
