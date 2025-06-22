variable "instance_name" {}
variable "machine_type" {}
variable "zone" {}
variable "network" {}
variable "subnetwork" {}
variable "enable_public_ip" {
  description = "Whether to assignn a publilc IP to this VM" 
  type = bool
  default = false
}
