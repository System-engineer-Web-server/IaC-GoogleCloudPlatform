resource "google_compute_firewall" "default" {
  name    = var.firewall_name
  network = var.network

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = var.protocol
    ports    = var.ports
  }
  source_ranges = var.source_ranges
}


