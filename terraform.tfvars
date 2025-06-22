project = "system-admin-460407"
region = "asia-southeast1"
zone = "asia-southeast1-b"
# subnet_name = "subnet-db"
name = "network-db" //network's name
subnet_range_1 = "10.0.0.0/24"
subnet_range_2 = "10.0.1.0/24"
machine_type = "e2-micro"
ports = ["80", "443", "8000", "9000", "9001", "5432"]
protocol = "tcp"
group_name = "master-slave"
file_scrpt = file("${path.module}/startup.sh")
target_size = 3
max_replicas = 5
min_replicas = 3
target = 0.6


