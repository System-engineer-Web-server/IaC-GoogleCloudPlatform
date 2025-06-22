variable "project" {}
variable "region" {}
//network and subnet
variable "network_name" {}
variable "subnet_1_name" {}
variable "subnet_2_name" {}
variable "subnet_1_range" {}
variable "subnet_2_range" {}
variable "subnet_1_region" {}
variable "subnet_2_region" {}

//group instance
variable "name" {}
variable "zone" {}
variable "max_replicas" {}
variable "min_replicas" {}
variable "target_cpu" {}
variable "machine_type" {}
variable "enable_public_ip" {
  type = bool
  default = false
}
variable "file_script" {
  type = string
  default = ""
}

//firewall
variable "ports" {
  type = list(string)
}

variable "source_ranges" {
  type = list(string)
}
