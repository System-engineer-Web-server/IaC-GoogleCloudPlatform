resource "google_compute_subnetwork" "subnet-1" {
  name          = var.subnet_1_name
  ip_cidr_range = var.subnet_1_range
  region        = var.subnet_1_region
  network       = google_compute_network.vpn.id
}

resource "google_compute_subnetwork" "subnet-2" {
  name          = var.subnet_2_name
  ip_cidr_range = var.subnet_2_range
  region        = var.subnet_2_region
  network       = google_compute_network.vpn.id
}

resource "google_compute_network" "vpn" {
  name                    = var.network_name
  auto_create_subnetworks = false
}
