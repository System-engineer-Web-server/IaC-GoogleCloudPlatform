# 🚀 GCP Infrastructure Deployment with Terraform

This project uses **Terraform** to deploy and manage infrastructure on **Google Cloud Platform (GCP)**.

## 📦 Requirements

Before you begin, install the following tools on your local machine:

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Google Cloud CLI (gcloud)](https://cloud.google.com/sdk/docs/install)

## 🔐 Authenticate with GCP

Login and authorize Terraform to interact with your GCP account:

```bash
gcloud auth application-default login
```

> This command opens a browser window for authentication. After completing, it will store credentials locally.

---

## 📥 Clone This Project

Clone the project to your local environment:

```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```

---

## 🛠️ Configure Your Variables

Edit the `terraform.tfvars` file to customize your deployment (e.g., project ID, region, zone, subnet ranges, etc.):

```hcl
project_id     = "your-gcp-project-id"
region         = "asia-southeast1"
zone           = "asia-southeast1-b"
bucket_name    = "your-unique-bucket-name"
machine_type   = "e2-micro"
target_size    = 3
```

---

## 🚀 Deploy with Terraform

Run the following commands to deploy your infrastructure:

```bash
terraform init         # Initialize Terraform and download required providers
terraform plan         # Review what Terraform will create or change
terraform apply        # Apply the changes and deploy resources
```

---

## ✅ Modules Used

- **network**: VPC and subnets
- **firewall**: Security rules
- **instance**: Compute Engine VMs
- **instance_group**: Managed instance groups with autoscaling
- **storage**: Cloud Storage buckets
- **iam**: Service Accounts and IAM bindings

---

## 📌 Notes

- Ensure you have sufficient quotas for instances and external IPs.
- Use `terraform destroy` to tear down infrastructure when no longer needed.

---

## 📫 Contact

For issues or questions, please open an issue or contact [your-email@example.com](mailto:your-email@example.com).

