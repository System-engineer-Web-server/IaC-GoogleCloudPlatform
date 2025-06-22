variable "firewall_name" {}
variable "network" {}
variable "protocol" {}
variable "ports" {
  description = "port list"
  type = list(string)
}

variable "source_ranges" {
  description = "source ranges"
  type = list(string)
}
