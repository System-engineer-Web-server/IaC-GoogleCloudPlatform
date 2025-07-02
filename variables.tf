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

variable "internal_static_ip" {
  description = "Internal static IP address to assign to the VM"
  type        = string
  default     = null
}

variable "instance_count" {
  type = number
  default = 1
}
variable "internal_ip" {
  type = list(string)
  default = [ "" ]
}

variable "ssh_user" {
  type = string
  default = "tn18624"
}
variable "ssh_pubkey_path" {
  type = string
  default = "/home/tn18624/.ssh/gg_cloud.pub"
}
