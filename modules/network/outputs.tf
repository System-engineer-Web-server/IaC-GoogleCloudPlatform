output "network_name" {
  value = google_compute_network.vpn.name
}
output "subnet_name_1" {
  value = google_compute_subnetwork.subnet_1.name
}
output "subnet_name_2" {
  value = google_compute_subnetwork.subnet_2.name
}
output "subnet_link_1" {
  value = google_compute_subnetwork.subnet_1.self_link
}

output "subnet_link_2" {
  value = google_compute_subnetwork.subnet_2.self_link
}

