output "subnet_1" {
  value = google_compute_subnetwork.subnet-1.self_link
}

output "subnet_2" {
  value = google_compute_subnetwork.subnet-2.self_link
}
output "network_name" {
  value = google_compute_network.vpn.name 
}
