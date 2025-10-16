# All Clouds Example

This example deploys infrastructure to AWS, GCP, and Azure simultaneously.

## Resources Created

### AWS (7 resources)
- VPC, Subnet, Internet Gateway, Route Table
- Security Group
- EC2 Instance

### GCP (5 resources)
- VPC Network, Subnet
- Firewall Rules
- Compute Instance

### Azure (7 resources)
- Resource Group, VNet, Subnet
- Network Security Group, Public IP
- Network Interface, Linux VM

**Total: ~19 resources across 3 cloud providers**

## Prerequisites

- AWS CLI configured (`aws configure`)
- gcloud CLI configured (`gcloud auth application-default login`)
- Azure CLI configured (`az login`)
- Terraform installed
- SSH key pair for Azure (`ssh-keygen -t rsa -b 4096`)

## Usage

1. Generate SSH key for Azure (if not done):
   ```bash
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/azure_key
   ```

2. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. Edit `terraform.tfvars` with your settings for all three clouds

4. Deploy to all clouds:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

5. View all instance IPs:
   ```bash
   terraform output
   ```

6. Access instances:
   ```bash
   # AWS
   terraform output aws_instance_ip
   
   # GCP
   gcloud compute ssh terraform-instance --zone=us-central1-a
   
   # Azure
   ssh -i ~/.ssh/azure_key azureuser@$(terraform output -raw azure_vm_public_ip)
   ```

7. Clean up all resources:
   ```bash
   terraform destroy
   ```

## Cost

Estimated monthly cost: **~$30-45** (or ~$0 with free tiers)
- AWS: ~$10-15
- GCP: ~$7-12
- Azure: ~$13-18

💡 All three clouds offer free tier benefits!

## Deployment Time

Typical deployment time: **3-5 minutes**

## Notes

- This deploys infrastructure to all three major cloud providers
- Perfect for testing multi-cloud strategies
- Remember to destroy resources when done to avoid costs
- Each cloud can be managed independently using `-target` flag
