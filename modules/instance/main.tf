
resource "google_compute_instance" "default" {
  name = var.instance_count > 1 ? "${var.instance_name}-${count.index}" : var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  count = var.instance_count

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = var.network
    subnetwork = var.subnetwork
    network_ip = length(var.internal_ip) > count.index ? var.internal_ip[count.index] : null
    dynamic "access_config" {
      for_each = var.enable_public_ip ? [1] : []
      content {

      }
    }
  }
  metadata_startup_script = var.file_script

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pubkey_path)}"
  }
}
