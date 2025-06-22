output "subnet_link" {
  value = [
    module.network.subnet_1,
    module.network.subnet_2,
  ]
}
