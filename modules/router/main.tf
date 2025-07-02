resource "google_compute_router" "router" {
  name    = var.router_name
  region  = var.region
  network = var.network_name
}

resource "google_compute_router_nat" "nat_rules" {
  name   = var.nat_name
  router = google_compute_router.router.name
  region = google_compute_router.router.region

  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = var.subnetwork_id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
