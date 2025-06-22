variable "group_name" {}
variable "region" {}
variable "machine_type" {}
variable "network" {}
variable "subnetwork" {}
variable "enable_ip_internal" {
  type = bool
  default = false
}
variable "file_script" {
  type = string
  default = ""
}
variable "zone" {}
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


