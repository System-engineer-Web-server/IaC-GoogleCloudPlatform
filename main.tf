module "network" {
  source = "./modules/network/"
  network_name = var.network_name
  subnet_1_name = var.subnet_1_name
  subnet_2_name = var.subnet_2_name
  subnet_1_range = var.subnet_1_range
  subnet_2_range = var.subnet_2_range
  subnet_1_region = var.subnet_1_region
  subnet_2_region = var.subnet_2_region
}
//firewall 
module "firewall" {
  source = "./modules/firewall/"
  firewall_name = "open-port-service"
  network = module.network.network_name
  protocol = "tcp"
  ports = var.ports
  source_ranges = var.source_ranges
}

//db cluster
module "db-cluster-slave" {
  source = "./modules/group_instance/"
  name = var.name
  region = var.region
  zone = var.zone
  max_replicas = var.max_replicas
  min_replicas = var.min_replicas
  target_cpu = var.target_cpu
  machine_type = var.machine_type
  network = module.network.network_name
  subnetwork = module.network.subnet_1
  enable_public_ip = var.enable_public_ip
  # file_script = file(var.file_script)
}

// web-server, splunk, MinIO
module "web-server" {
  source = "./modules/instance/"
  instance_name = "web-server"
  machine_type = var.machine_type
  zone = "us-central1-b"
  network = module.network.network_name
  subnetwork = module.network.subnet_2
  enable_public_ip = true
  # file_script = file(var.file_script)
}

module "monitoring" {
  source = "./modules/instance/"
  instance_name = "monitoring"
  machine_type = var.machine_type
  zone = "us-central1-b"
  network = module.network.network_name
  subnetwork = module.network.subnet_2
  enable_public_ip = true
  file_script = file("/home/tn18624/IaC-GoogleCloudPlatform/scripts/splunk_install.sh")
}
module "storage" {
  source = "./modules/instance/"
  instance_name = "storage"
  machine_type = var.machine_type
  zone = "us-central1-b"
  network = module.network.network_name
  subnetwork = module.network.subnet_2
  enable_public_ip = true
  # file_script = file(var.file_script)
}
