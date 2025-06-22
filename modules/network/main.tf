resource "google_compute_subnetwork" "subnet_1" {
  name          = "${var.name}-1"
  ip_cidr_range = var.subnet_range_1
  region        =  var.region
  network       = google_compute_network.vpn.id
}
resource "google_compute_subnetwork" "subnet_2" {
  name          = "${var.name}-2"
  ip_cidr_range = var.subnet_range_2
  region        =  "us-central1"
  network       = google_compute_network.vpn.id
}


resource "google_compute_network" "vpn" {
  name                    = var.name
  auto_create_subnetworks = false
}
