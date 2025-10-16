# GCP Only Example

This example deploys infrastructure to Google Cloud Platform only.

## Resources Created

- VPC Network with custom subnet
- Firewall rules (SSH, HTTP, HTTPS)
- Compute Engine instance

## Prerequisites

- gcloud CLI configured (`gcloud auth application-default login`)
- GCP project with billing enabled
- Terraform installed

## Usage

1. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your GCP settings:
   ```hcl
   gcp_project           = "your-project-id"
   gcp_region            = "us-central1"
   instance_machine_type = "e2-micro"
   instance_image        = "debian-cloud/debian-12"
   ```

3. Deploy:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. Get the instance IP:
   ```bash
   terraform output gcp_instance_ip
   ```

5. Clean up:
   ```bash
   terraform destroy
   ```

## Cost

Estimated monthly cost: **~$7-12**
- e2-micro: ~$6.11/month
- Persistent disk: ~$0.40/month
- Free tier eligible: Yes (e2-micro included)
