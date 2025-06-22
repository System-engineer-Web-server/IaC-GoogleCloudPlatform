
resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = var.network
    subnetwork = var.subnetwork
    dynamic "access_config" {
      for_each = var.enable_public_ip ? [1] : []
      content {
      }
    }
  }
  metadata_startup_script = var.file_script
}
