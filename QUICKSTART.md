# Quick Start Guide

Get your multi-cloud infrastructure up and running in 10 minutes!

## Prerequisites Check

Before you start, verify you have:
- [ ] AWS Account
- [ ] GCP Account with billing enabled
- [ ] Azure Account with active subscription
- [ ] Terraform installed (`terraform --version`)
- [ ] AWS CLI installed (`aws --version`)
- [ ] gcloud CLI installed (`gcloud --version`)
- [ ] Azure CLI installed (`az --version`)

## Step-by-Step Setup

### 1. Configure AWS (Choose one method)

**Method A: AWS CLI**
```bash
aws configure
# Enter your AWS Access Key ID
# Enter your AWS Secret Access Key
# Enter default region (e.g., us-east-1)
```

**Method B: Environment Variables (PowerShell)**
```powershell
$env:AWS_ACCESS_KEY_ID="your-access-key-id"
$env:AWS_SECRET_ACCESS_KEY="your-secret-access-key"
$env:AWS_DEFAULT_REGION="us-east-1"
```

### 2. Configure GCP (Choose one method)

**Method A: gcloud CLI (Recommended)**
```bash
# Authenticate
gcloud auth application-default login

# Set your project
gcloud config set project YOUR_PROJECT_ID
```

**Method B: Service Account Key**
```powershell
# Download key from GCP Console > IAM & Admin > Service Accounts
$env:GOOGLE_APPLICATION_CREDENTIALS="C:\path\to\your\service-account-key.json"
```

### 3. Configure Azure (Choose one method)

**Method A: Azure CLI (Recommended)**
```bash
az login
# Follow browser prompts to authenticate
```

**Method B: Service Principal (PowerShell)**
```powershell
$env:ARM_CLIENT_ID="your-client-id"
$env:ARM_CLIENT_SECRET="your-client-secret"
$env:ARM_SUBSCRIPTION_ID="your-subscription-id"
$env:ARM_TENANT_ID="your-tenant-id"
```

### 4. Generate SSH Key for Azure

```bash
# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -f ~/.ssh/azure_key

# On Windows PowerShell:
ssh-keygen -t rsa -b 4096 -f $env:USERPROFILE\.ssh\azure_key

# The public key will be in ~/.ssh/azure_key.pub (Linux/Mac)
# or $env:USERPROFILE\.ssh\azure_key.pub (Windows)
```

### 5. Find Your AWS AMI ID

1. Go to [AWS Console](https://console.aws.amazon.com/ec2/)
2. Navigate to: EC2 → Images → AMIs
3. Select "Public images"
4. Search for: `amazon/amzn2-ami-hvm` or `ubuntu/images/hvm-ssd/ubuntu-jammy-22.04`
5. Filter by your region
6. Copy the AMI ID (format: `ami-xxxxxxxxx`)

### 6. Create Your Configuration File

```bash
# Copy the example
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars`:
```hcl
# AWS Settings
aws_region    = "us-east-1"           # Your AWS region
instance_ami  = "ami-0c55b159cbfafe1f0"  # AMI ID from step 5
instance_type = "t2.micro"            # Free tier eligible

# GCP Settings
gcp_project           = "my-project-123456"  # YOUR GCP PROJECT ID
gcp_region            = "us-central1"
instance_machine_type = "e2-micro"          # Free tier eligible
instance_image        = "debian-cloud/debian-12"

# Azure Settings
azure_location    = "East US"
vm_size           = "Standard_B1s"    # Free tier eligible
admin_username    = "azureuser"
ssh_public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQ..."  # From step 4
vm_image_publisher = "Canonical"
vm_image_offer     = "0001-com-ubuntu-server-jammy"
vm_image_sku       = "22_04-lts-gen2"
```

### 7. Initialize Terraform

```bash
terraform init
```

Expected output:
```
Initializing modules...
Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 5.0"...
- Finding hashicorp/google versions matching "~> 5.0"...
- Finding hashicorp/azurerm versions matching "~> 3.0"...
Terraform has been successfully initialized!
```

### 8. Preview Changes

```bash
terraform plan
```

Review the output - you should see:
- AWS: ~7 resources to create (VPC, subnet, security group, EC2, etc.)
- GCP: ~5 resources to create (VPC, subnet, firewall rules, compute instance)
- Azure: ~7 resources to create (Resource group, VNet, NSG, VM, etc.)

### 9. Deploy Infrastructure

```bash
terraform apply
```

Type `yes` when prompted.

⏱️ **Expected time**: 3-5 minutes

### 10. View Your Resources

```bash
# See all outputs
terraform output

# Get specific IPs
terraform output aws_instance_ip
terraform output gcp_instance_ip
terraform output azure_vm_public_ip
```

### 11. Access Your Instances

**AWS Instance:**
```bash
# Get the IP
$aws_ip = terraform output -raw aws_instance_ip

# SSH (requires SSH key - see note below)
ssh ec2-user@$aws_ip
```

**GCP Instance:**
```bash
# Get the IP
$gcp_ip = terraform output -raw gcp_instance_ip

# SSH (requires gcloud configuration)
gcloud compute ssh terraform-instance --zone=us-central1-a
```

**Azure VM:**
```bash
# Get the IP
$azure_ip = terraform output -raw azure_vm_public_ip

# SSH using your private key
ssh -i ~/.ssh/azure_key azureuser@$azure_ip

# On Windows PowerShell:
ssh -i $env:USERPROFILE\.ssh\azure_key azureuser@$azure_ip
```

### 12. Clean Up (When Done)

```bash
terraform destroy
```

Type `yes` when prompted.

---

## Common Issues & Solutions

### ❌ "Error: Invalid AMI ID"
**Solution**: Update `instance_ami` with a valid AMI for your region (see Step 3)

### ❌ "Error: No valid credential sources found" (AWS)
**Solution**: Run `aws configure` or set environment variables (see Step 1)

### ❌ "Error: googleapi: Error 403" (GCP)
**Solution**: 
1. Ensure billing is enabled on your GCP project
2. Run `gcloud auth application-default login`
3. Verify your project ID is correct

### ❌ "Error: SSH public key is required" (Azure)
**Solution**: Generate SSH key and add to terraform.tfvars:
```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/azure_key
# Copy contents of ~/.ssh/azure_key.pub to terraform.tfvars
```

### ❌ "Error: building account" (Azure)
**Solution**: Run `az login` to authenticate with Azure

### ❌ "Error: Error locking state file"
**Solution**: Someone else is running Terraform, or a previous run crashed
```bash
terraform force-unlock <LOCK_ID>
```

### ❌ Module not found errors
**Solution**: Run `terraform init` again

---

## Cost Reminders

### AWS Costs (Approximate)
- t2.micro: ~$8.50/month (750 hours free tier)
- EBS: ~$0.80/month
- Data transfer: First 1 GB free

### GCP Costs (Approximate)
- e2-micro: ~$6.11/month (included in free tier)
- Disk: ~$0.40/month
- Data transfer: First 1 GB free

### Azure Costs (Approximate)
- Standard_B1s: ~$7.59/month (750 hours free tier)
- Managed Disk: ~$1.50/month
- Public IP: ~$3.65/month
- Data transfer: First 5 GB free

💡 **Tip**: Always run `terraform destroy` when done testing!

---

## Next Steps

Once your infrastructure is running:

1. **Customize Security Groups**: Restrict SSH access to your IP only
2. **Add SSH Keys**: Configure SSH key pairs for secure access (AWS/GCP)
3. **Deploy Applications**: Install software on your instances
4. **Set Up Monitoring**: Configure CloudWatch (AWS), Cloud Monitoring (GCP), Azure Monitor
5. **Implement CI/CD**: Automate deployments with GitHub Actions

---

## Getting Help

- 📖 Read the full [README.md](README.md)
- 📝 Check the [CHANGELOG.md](CHANGELOG.md) for details
- 🐛 Report issues on GitHub
- 💬 Join Terraform community forums

---

**🎉 Congratulations!** You now have a multi-cloud infrastructure running on AWS, GCP, and Azure!
