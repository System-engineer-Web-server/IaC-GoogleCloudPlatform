variable "instance_name" {}
variable "machine_type" {}
variable "zone" {}
variable "network" {}
variable "ssh_user" {
  type = string
  default = "tn18624"
}
variable "ssh_pubkey_path" {
  type = string
  default = "/home/tn18624/.ssh/gg_cloud.pub"
}
variable "instance_count" {
  type = number
  default = 1
}
variable "internal_ip" {
  type = list(string)
  default = [ "" ]
}
variable "subnetwork" {}
variable "enable_public_ip" {
  type = bool
  default = false
}

variable "file_script" {
  type = string
  default = ""
}

variable "internal_static_ip" {
  description = "Internal static IP address to assign to the VM"
  type        = string
  default     = null
}


