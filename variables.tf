variable "project" {}
variable "region" {}
variable "zone" {}
# variable "subnet_name" {}
variable "name" {}
variable "subnet_range_1" {}
variable "subnet_range_2" {}
variable "machine_type" {}
variable "protocol" {}
variable "ports" {}
variable "group_name" {}
variable "file_script" {
  type = string
  default = ""
}
variable "target_size" {
  type = number
  default = 3
}
variable "max_replicas" {
  type = number
  default = 5
}
variable "min_replicas" {
  type = number
  default = 3
}
variable "target" {
  default = 0.6
}


