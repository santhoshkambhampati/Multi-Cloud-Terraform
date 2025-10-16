# Azure Only Example

This example deploys infrastructure to Microsoft Azure only.

## Resources Created

- Resource Group
- Virtual Network with subnet
- Network Security Group (SSH, HTTP, HTTPS)
- Public IP address
- Linux Virtual Machine (Ubuntu 22.04 LTS)

## Prerequisites

- Azure CLI configured (`az login`)
- Azure subscription
- Terraform installed
- SSH key pair generated

## Usage

1. Generate SSH key (if not already done):
   ```bash
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/azure_key
   ```

2. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. Edit `terraform.tfvars` with your Azure settings:
   ```hcl
   azure_location = "East US"
   vm_size        = "Standard_B1s"
   admin_username = "azureuser"
   ssh_public_key = "ssh-rsa AAAAB3..."  # From ~/.ssh/azure_key.pub
   ```

4. Deploy:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

5. Get the VM IP:
   ```bash
   terraform output azure_vm_public_ip
   ```

6. SSH into the VM:
   ```bash
   ssh -i ~/.ssh/azure_key azureuser@$(terraform output -raw azure_vm_public_ip)
   ```

7. Clean up:
   ```bash
   terraform destroy
   ```

## Cost

Estimated monthly cost: **~$13-18**
- Standard_B1s VM: ~$7.59/month
- Managed disk: ~$1.50/month
- Static public IP: ~$3.65/month
- Free tier eligible: Yes (750 hours/month)
