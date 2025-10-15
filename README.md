# Multi-Cloud Terraform Demo Infrastructure

![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=flat&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=flat&logo=amazon-aws&logoColor=white)
![Google Cloud](https://img.shields.io/badge/Google%20Cloud-%234285F4.svg?style=flat&logo=google-cloud&logoColor=white)
![Azure](https://img.shields.io/badge/Azure-%230078D4.svg?style=flat&logo=microsoft-azure&logoColor=white)

A production-ready Terraform project demonstrating multi-cloud infrastructure deployment across AWS, Google Cloud Platform (GCP), and Microsoft Azure. This project showcases best practices for infrastructure as code, modular design, and secure cloud resource management.

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
- [Usage](#usage)
- [Resources Created](#resources-created)
- [Security Considerations](#security-considerations)
- [Cost Estimates](#cost-estimates)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## 🎯 Overview

This project demonstrates how to use Terraform to deploy and manage resources across multiple cloud providers simultaneously. It implements:

- **Modular Architecture**: Separate modules for AWS, GCP, and Azure
- **Security Best Practices**: No hardcoded credentials, proper network isolation
- **Network Configuration**: VPCs, subnets, security groups, and firewalls
- **Variable Validation**: Input validation to prevent configuration errors
- **Resource Tagging**: Proper labeling for resource organization

## 🏗️ Architecture

### AWS Architecture
- **VPC**: Isolated virtual network (10.0.0.0/16)
- **Public Subnet**: 10.0.1.0/24 with internet gateway
- **Security Group**: SSH (port 22) and HTTP (port 80) access
- **EC2 Instance**: Compute instance with public IP

### GCP Architecture
- **VPC Network**: Custom VPC with manual subnet creation
- **Subnet**: Regional subnet (10.0.1.0/24)
- **Firewall Rules**: SSH and HTTP/HTTPS access
- **Compute Instance**: VM instance with external IP

### Azure Architecture
- **Resource Group**: Logical container for Azure resources
- **Virtual Network**: Isolated network (10.0.0.0/16)
- **Subnet**: 10.0.1.0/24 within the VNet
- **Network Security Group**: SSH, HTTP, and HTTPS access rules
- **Public IP**: Static public IP address
- **Linux VM**: Ubuntu 22.04 LTS virtual machine with SSH access

## ✅ Prerequisites

Before you begin, ensure you have the following:

### Required Tools
- **Terraform** >= 1.0 ([Installation Guide](https://developer.hashicorp.com/terraform/downloads))
- **AWS CLI** ([Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html))
- **gcloud CLI** ([Installation Guide](https://cloud.google.com/sdk/docs/install))
- **Azure CLI** ([Installation Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli))

### Cloud Account Requirements

#### AWS
1. AWS Account with appropriate permissions
2. AWS credentials configured using one of these methods:
   - **Environment Variables**: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
   - **AWS CLI**: Run `aws configure`
   - **IAM Role**: If running on EC2

#### GCP
1. Google Cloud Platform account with billing enabled
2. A GCP Project created
3. GCP credentials configured using one of these methods:
   - **Service Account Key**: Set `GOOGLE_APPLICATION_CREDENTIALS` environment variable
   - **gcloud CLI**: Run `gcloud auth application-default login`
   - **Compute Engine Service Account**: If running on GCP

#### Azure
1. Microsoft Azure account with an active subscription
2. Azure credentials configured using one of these methods:
   - **Azure CLI**: Run `az login`
   - **Service Principal**: Set environment variables:
     - `ARM_CLIENT_ID`
     - `ARM_CLIENT_SECRET`
     - `ARM_SUBSCRIPTION_ID`
     - `ARM_TENANT_ID`
   - **Managed Identity**: If running on Azure VM

## 📁 Project Structure

```
Multi-Cloud-Terraform/
├── main.tf                      # Root module - orchestrates AWS, GCP, and Azure modules
├── variables.tf                 # Root-level variable definitions
├── terraform.tfvars.example     # Example variables file (copy to terraform.tfvars)
├── .gitignore                   # Git ignore rules for sensitive files
├── README.md                    # This file
│
├── AWS/                         # AWS module
│   ├── main.tf                  # AWS provider, VPC, EC2 resources
│   ├── variables.tf             # AWS-specific variables
│   └── outputs.tf               # AWS resource outputs
│
├── GCP/                         # GCP module
│   ├── main.tf                  # GCP provider, network, compute resources
│   ├── variables.tf             # GCP-specific variables
│   └── outputs.tf               # GCP resource outputs
│
└── Azure/                       # Azure module
    ├── main.tf                  # Azure provider, VNet, VM resources
    ├── variables.tf             # Azure-specific variables
    └── outputs.tf               # Azure resource outputs
```

## 🚀 Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/santhoshkambhampati/Multi-Cloud-Terraform.git
cd Multi-Cloud-Terraform
```

### 2. Configure AWS Credentials

**Option A: Using AWS CLI**
```bash
aws configure
```

**Option B: Using Environment Variables (PowerShell)**
```powershell
$env:AWS_ACCESS_KEY_ID="your-access-key"
$env:AWS_SECRET_ACCESS_KEY="your-secret-key"
$env:AWS_DEFAULT_REGION="us-east-1"
```

### 3. Configure GCP Credentials

**Option A: Using gcloud CLI**
```bash
gcloud auth application-default login
gcloud config set project YOUR_PROJECT_ID
```

**Option B: Using Service Account Key**
```powershell
# Download service account key from GCP Console
$env:GOOGLE_APPLICATION_CREDENTIALS="C:\path\to\your\credentials.json"
```

### 4. Configure Azure Credentials

**Option A: Using Azure CLI (Recommended)**
```bash
az login
```

**Option B: Using Service Principal (PowerShell)**
```powershell
$env:ARM_CLIENT_ID="your-client-id"
$env:ARM_CLIENT_SECRET="your-client-secret"
$env:ARM_SUBSCRIPTION_ID="your-subscription-id"
$env:ARM_TENANT_ID="your-tenant-id"
```

### 5. Generate SSH Key for Azure

Azure requires an SSH public key for VM access:

```bash
# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -f ~/.ssh/azure_key

# The public key will be in ~/.ssh/azure_key.pub
# Copy its contents to use in terraform.tfvars
```

### 6. Create terraform.tfvars File

```bash
# Copy the example file
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your specific values:

```hcl
# AWS Configuration
aws_region    = "us-east-1"
instance_ami  = "ami-0c55b159cbfafe1f0"  # Update to valid AMI in your region
instance_type = "t2.micro"

# GCP Configuration
gcp_project           = "your-gcp-project-id"  # REQUIRED: Your GCP project ID
gcp_region            = "us-central1"
instance_machine_type = "e2-micro"
instance_image        = "debian-cloud/debian-12"

# Azure Configuration
azure_location    = "East US"
vm_size           = "Standard_B1s"
admin_username    = "azureuser"
ssh_public_key    = "ssh-rsa AAAAB3NzaC1yc2E..."  # REQUIRED: Your SSH public key
vm_image_publisher = "Canonical"
vm_image_offer     = "0001-com-ubuntu-server-jammy"
vm_image_sku       = "22_04-lts-gen2"
```

**Important**: Find a valid AMI ID for your AWS region:
- Go to AWS Console > EC2 > AMIs > Public Images
- Search for "Amazon Linux 2023" or "Ubuntu 22.04 LTS"
- Copy the AMI ID for your selected region

### 7. Initialize Terraform

```bash
terraform init
```

This command:
- Downloads required provider plugins (AWS, GCP, Azure)
- Initializes the backend
- Prepares modules for use

### 8. Review the Execution Plan

```bash
terraform plan
```

This shows you what resources will be created before applying changes.

### 9. Deploy the Infrastructure

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment.

## 💻 Usage

### Deploying Resources

```bash
# Full deployment
terraform apply -auto-approve

# Deploy only AWS resources
terraform apply -target=module.aws_resources

# Deploy only GCP resources
terraform apply -target=module.gcp_resources

# Deploy only Azure resources
terraform apply -target=module.azure_resources
```

### Viewing Outputs

```bash
# View all outputs
terraform output

# View specific outputs
terraform output aws_instance_ip
terraform output gcp_instance_ip
terraform output azure_vm_public_ip
```

### Destroying Resources

```bash
# Destroy all resources
terraform destroy

# Destroy specific module
terraform destroy -target=module.aws_resources
```

## 🔧 Resources Created

### AWS Resources
| Resource Type | Name | Description |
|--------------|------|-------------|
| VPC | `terraform-vpc` | Virtual Private Cloud (10.0.0.0/16) |
| Subnet | `terraform-public-subnet` | Public subnet (10.0.1.0/24) |
| Internet Gateway | `terraform-igw` | Internet connectivity |
| Route Table | `terraform-public-rt` | Routing for public subnet |
| Security Group | `terraform-instance-sg` | Firewall rules (SSH, HTTP) |
| EC2 Instance | `terraform-ec2-instance` | Compute instance |

### GCP Resources
| Resource Type | Name | Description |
|--------------|------|-------------|
| VPC Network | `terraform-vpc` | Virtual Private Cloud |
| Subnet | `terraform-subnet` | Regional subnet (10.0.1.0/24) |
| Firewall Rule | `terraform-allow-ssh` | SSH access (port 22) |
| Firewall Rule | `terraform-allow-http` | HTTP/HTTPS access |
| Compute Instance | `terraform-instance` | VM instance |

### Azure Resources
| Resource Type | Name | Description |
|--------------|------|-------------|
| Resource Group | `terraform-resources` | Logical container for resources |
| Virtual Network | `terraform-vnet` | Virtual network (10.0.0.0/16) |
| Subnet | `terraform-subnet` | Subnet (10.0.1.0/24) |
| Network Security Group | `terraform-nsg` | Firewall rules (SSH, HTTP, HTTPS) |
| Public IP | `terraform-public-ip` | Static public IP address |
| Network Interface | `terraform-nic` | VM network interface |
| Linux VM | `terraform-vm` | Ubuntu 22.04 LTS virtual machine |

## 🔒 Security Considerations

### ✅ Best Practices Implemented

1. **No Hardcoded Credentials**: Uses environment variables and credential files
2. **VPC Isolation**: Resources deployed in isolated VPCs
3. **Security Groups/Firewalls**: Controlled inbound/outbound traffic
4. **Gitignore Protection**: Sensitive files excluded from version control
5. **Input Validation**: Variables validated to prevent misconfigurations
6. **Resource Tagging**: All resources properly labeled

### ⚠️ Security Recommendations

1. **Restrict SSH Access**: Update security group rules to allow SSH only from your IP:
   ```hcl
   # In AWS/main.tf, change:
   cidr_blocks = ["0.0.0.0/0"]  # To:
   cidr_blocks = ["YOUR_IP/32"]
   ```

2. **Use SSH Keys**: Add SSH key pairs for secure instance access
3. **Enable MFA**: Use multi-factor authentication for cloud accounts
4. **Regular Audits**: Review firewall rules and security groups periodically
5. **State File Security**: Consider using remote backend with encryption

## 💰 Cost Estimates

### AWS (us-east-1)
- **EC2 t2.micro**: ~$0.0116/hour (~$8.50/month)
- **EBS Volume**: ~$0.10/GB/month (8GB = $0.80/month)
- **Data Transfer**: First 1GB free, then $0.09/GB
- **Estimated Monthly Cost**: ~$10-15/month

### GCP (us-central1)
- **e2-micro**: ~$0.0084/hour (~$6.11/month)
- **Persistent Disk**: ~$0.04/GB/month (10GB = $0.40/month)
- **Egress Traffic**: First 1GB free, then $0.12/GB
- **Estimated Monthly Cost**: ~$7-12/month

### Azure (East US)
- **Standard_B1s VM**: ~$0.0104/hour (~$7.59/month)
- **Managed Disk**: ~$0.05/GB/month (30GB = $1.50/month)
- **Public IP**: ~$3.65/month (static)
- **Egress Traffic**: First 5GB free, then $0.087/GB
- **Estimated Monthly Cost**: ~$13-18/month

**Total Estimated Cost**: ~$30-45/month

💡 **Tip**: All three providers offer free tier options. Check eligibility at:
- [AWS Free Tier](https://aws.amazon.com/free/)
- [GCP Free Tier](https://cloud.google.com/free)
- [Azure Free Tier](https://azure.microsoft.com/en-us/free/)

## 🔍 Troubleshooting

### Common Issues

#### Issue: "Error: Invalid AMI ID"
**Solution**: AMI IDs are region-specific. Find a valid AMI for your region in AWS Console.

#### Issue: "Error: Error creating instance: googleapi: Error 403"
**Solution**: Ensure billing is enabled on your GCP project and you have necessary permissions.

#### Issue: "Error: SSH public key is required"
**Solution**: Generate an SSH key pair and add the public key to `terraform.tfvars`:
```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/azure_key
# Copy contents of ~/.ssh/azure_key.pub to terraform.tfvars
```

#### Issue: "Error: building account: Azure CLI not authenticated"
**Solution**: Run `az login` to authenticate with Azure CLI.

#### Issue: "Error: No valid credential sources found"
**Solution**: Configure AWS/GCP credentials using the methods described in [Setup Instructions](#setup-instructions).

#### Issue: "Error: Module not installed"
**Solution**: Run `terraform init` to download and initialize modules.

#### Issue: Resources already exist
**Solution**: Import existing resources or use a different resource name:
```bash
terraform import module.aws_resources.aws_instance.example i-1234567890abcdef0
```

### Getting Help

- Check Terraform logs: `TF_LOG=DEBUG terraform apply`
- Review AWS CloudTrail logs for API errors
- Check GCP Cloud Logging for operation details

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 📧 Contact

Santhosh Kambhampati - [@santhoshkambhampati](https://github.com/santhoshkambhampati)

Project Link: [https://github.com/santhoshkambhampati/Multi-Cloud-Terraform](https://github.com/santhoshkambhampati/Multi-Cloud-Terraform)

---

**Note**: Always destroy resources when not in use to avoid unnecessary charges:
```bash
terraform destroy
```