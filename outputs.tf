output "subnet_links" {
  value = [
    module.network.subnet_link_1,
    module.network.subnet_link_2
  ]
}

