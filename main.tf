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

module "nat" {
  source = "./modules/router/"
  region = var.subnet_2_region
  router_name = "router-subnet-2"
  network_name = module.network.network_name
  subnetwork_id = module.network.subnetwork_id_2
  nat_name = "nat-subnet-2"
}

//firewall 
module "firewall-1" {
  source = "./modules/firewall/"
  firewall_name = "port-service"
  network = module.network.network_name
  protocol = "tcp"
  ports = ["5432"]
  source_ranges = ["10.0.0.0/16"]
}

module "firewall-2" {
  source = "./modules/firewall/"
  firewall_name = "public-port"
  network = module.network.network_name
  protocol = "tcp"
  ports = ["22", "80", "443", "8000", "8404"]
  source_ranges = var.source_ranges
}

//db cluster
module "db-master" {
  source = "./modules/instance/"
  instance_name = "db-master"
  network = module.network.network_name
  machine_type = var.machine_type
  subnetwork = module.network.subnet_1
  zone = var.zone
  instance_count = 1
  enable_public_ip = var.enable_public_ip
  internal_ip = ["10.0.1.2"]
  file_script = file("/home/tn18624/IaC-GoogleCloudPlatform/scripts/master_install.sh")
}

module "db-slave" {
  source = "./modules/instance/"
  instance_name = "db-slave"
  network = module.network.network_name
  machine_type = var.machine_type
  subnetwork = module.network.subnet_1
  zone = var.zone
  instance_count = 2
  enable_public_ip = var.enable_public_ip
  internal_ip = ["10.0.1.3", "10.0.1.4"]
  file_script = file("/home/tn18624/IaC-GoogleCloudPlatform/scripts/slave_install.sh")
}

// web-server, splunk, MinIO
module "web-server-haproxy" {
  source = "./modules/instance/"
  instance_name = "web-server-haproxy"
  machine_type = var.machine_type
  zone = "us-central1-b"
  network = module.network.network_name
  subnetwork = module.network.subnet_2
  enable_public_ip = true
  file_script = file("/home/tn18624/IaC-GoogleCloudPlatform/scripts/web_ha.sh")
  depends_on = [ 
    module.web-server
  ]
}

module "web-server" {
  source = "./modules/instance/"
  instance_name = "web-server"
  network = module.network.network_name
  machine_type = var.machine_type
  subnetwork = module.network.subnet_2
  zone = "us-central1-b"
  enable_public_ip = false
  instance_count = 2
  file_script = file("/home/tn18624/IaC-GoogleCloudPlatform/scripts/web_server.sh") 
}

module "monitoring" {
  source = "./modules/instance/"
  instance_name = "monitoring"
  machine_type = var.machine_type
  zone = "us-central1-b"
  network = module.network.network_name
  enable_public_ip = true
  subnetwork = module.network.subnet_2
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
