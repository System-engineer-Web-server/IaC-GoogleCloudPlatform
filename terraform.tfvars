project = "system-admin-460407"
region = "asia-southeast1"

// netowrk
network_name = "vpn"
subnet_1_name = "db" 
subnet_2_name = "server"
subnet_1_range = "10.0.1.0/24"
subnet_2_range = "10.0.2.0/24"
subnet_1_region = "asia-southeast1"
subnet_2_region = "us-central1"

//group_instance
name = "cluster-slave"
zone = "asia-southeast1-b"
max_replicas = 5
min_replicas = 3
target_cpu = 0.6
machine_type = "e2-mdedium"
enable_public_ip = true
file_script = "~/thien.txt"

//firewall
ports = ["80", "443", "22", "8000"]
source_ranges = ["0.0.0.0/0"]


