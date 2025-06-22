module "network" {
  name = var.name
  source = "./modules/network/"
  region = var.region
  subnet_range_1 = var.subnet_range_1
  subnet_range_2 = var.subnet_range_2
}

module "firewall" {
  source = "./modules/firewall/"
  network = module.network.network_name
  firewall_name = "firewall"
  protocol = var.protocol
  ports = var.ports
}

// master-slave database
# module "master" {
#   source = "./modules/instance/"
#   instance_name = "master-db"
#   zone = var.zone
#   machine_type = var.machine_type
#   network = module.network.network_name
#   subnetwork = module.network.subnet_name
#   enable_public_ip = true
# }
#
# module "slave-1" {
#   source = "./modules/instance/"
#   instance_name = "slave-1"
#   zone = var.zone
#   machine_type = var.machine_type
#   network = module.network.network_name
#   subnetwork = module.network.subnet_name
#   enable_public_ip = false
# }
#
# module "slave-2" {
#   source = "./modules/instance/"
#   instance_name = "slave-2"
#   zone = var.zone
#   machine_type = var.machine_type
#   network = module.network.network_name
#   subnetwork = module.network.subnet_name
#   enable_public_ip = false
# }

module "master-slave" {
  source = "./modules/instance_group/"
  group_name = var.group_name
  machine_type = var.machine_type
  network = module.network.network_name
  subnetwork = module.network.subnet_link_2
  enable_ip_internal = true
  file_script = file("~/pg_backup.sh")
  region = "us-central1"
  zone = "us-central1-b" 
  target_size = var.target_size
  max_replicas = var.max_replicas
  min_replicas = var.min_replicas
  target = var.target
}

// WEB-SERVER
module "web-server" {
  source = "./modules/instance/"
  instance_name = "web-server"
  zone = var.zone
  machine_type = var.machine_type
  network = module.network.network_name
  subnetwork = module.network.subnet_name_1
  enable_public_ip = true
}

// Storage
module "minio-storage" {
  source = "./modules/instance/"
  instance_name = "minio-storage"
  zone = var.zone
  machine_type = var.machine_type
  network = module.network.network_name
  subnetwork = module.network.subnet_name_1
  enable_public_ip = false
}

// Splunk monitoring
module "monitoring" {
  source = "./modules/instance/"
  instance_name = "monitoring"
  zone = var.zone
  machine_type = var.machine_type
  network = module.network.network_name
  subnetwork = module.network.subnet_name_1
  enable_public_ip = true
}

