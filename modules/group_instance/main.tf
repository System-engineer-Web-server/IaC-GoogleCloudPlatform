resource "google_compute_autoscaler" "default" {
  name   = "${var.name}-autoscaler" 
  zone   = var.zone
  target = google_compute_instance_group_manager.db-cluster.id

  autoscaling_policy {
    max_replicas    = var.max_replicas
    min_replicas    = var.min_replicas
    cpu_utilization {
      target = var.target_cpu
    }
  }
}

resource "google_compute_instance_template" "default" {
  name        = "${var.name}-instance"
  machine_type         = var.machine_type
  region = var.region

  disk {
    source_image      = "debian-cloud/debian-11"
    auto_delete       = true
    boot              = true
  }

  network_interface {
    network = var.network
    subnetwork = var.subnetwork
    dynamic "access_config" {
      for_each = var.enable_public_ip ? [1] : [0]
      content {
        
      }
    }
  }
  metadata_startup_script = var.file_script
}

resource "google_compute_instance_group_manager" "db-cluster" {
  name     = "${var.name}-db"
  base_instance_name = "db-cluster"
  zone               = var.zone
  target_size = 3

  version {
    name              = "${var.name}-db" 
    instance_template = google_compute_instance_template.default.self_link_unique
  }
}

