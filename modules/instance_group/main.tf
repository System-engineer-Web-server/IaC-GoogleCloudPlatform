resource "google_compute_instance_template" "db" {

  name         = var.group_name
  machine_type = var.machine_type

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = var.network
    subnetwork = var.subnetwork
    dynamic "access_config" {
      for_each = var.enable_ip_internal ? [1] : [0]
      content {}
    }
  }
  metadata_startup_script = var.file_script
}

resource "google_compute_instance_group_manager" "db-server" {
  name     = "${var.group_name}-db"

  base_instance_name = var.group_name
  zone               = var.zone

  target_size = var.target_size

  version {
    instance_template = google_compute_instance_template.db.self_link_unique
  }
}

resource "google_compute_autoscaler" "db-autosclaer" {
  name   = "${var.group_name}-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.db-server.id

  autoscaling_policy {
    max_replicas    = var.max_replicas
    min_replicas    = var.min_replicas 
    cpu_utilization {
      target = var.target
    }
  }
}
