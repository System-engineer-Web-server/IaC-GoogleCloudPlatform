variable "name" {}
variable "zone" {}
variable "region" {}
variable "max_replicas" {}
variable "min_replicas" {}
variable "target_cpu" {}
variable "machine_type" {}
variable "network" {}
variable "subnetwork" {}
variable "enable_public_ip" {
  type = bool
  default = false
}
variable "file_script" {
  type = string
  default = ""
}
