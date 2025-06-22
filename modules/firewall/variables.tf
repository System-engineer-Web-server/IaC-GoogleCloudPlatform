variable "network" {}
variable "firewall_name" {}
variable "protocol" {}
variable "ports" {
  type = list(string)
}
