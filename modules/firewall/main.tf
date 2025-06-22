resource "google_compute_firewall" "this" {
  name    = var.firewall_name
  network = var.network  # Sử dụng network được truyền từ bên ngoài

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = var.protocol
    ports    = var.ports
  }

  source_ranges = ["10.0.0.0/24"]
}
