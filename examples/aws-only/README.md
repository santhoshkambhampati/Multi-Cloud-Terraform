# AWS Only Example

This example deploys infrastructure to AWS only.

## Resources Created

- VPC with public subnet
- Internet Gateway and Route Table
- Security Group (SSH and HTTP access)
- EC2 Instance

## Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform installed

## Usage

1. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your AWS settings:
   ```hcl
   aws_region    = "us-east-1"
   instance_ami  = "ami-0c55b159cbfafe1f0"  # Update for your region
   instance_type = "t2.micro"
   ```

3. Deploy:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. Get the instance IP:
   ```bash
   terraform output aws_instance_ip
   ```

5. Clean up:
   ```bash
   terraform destroy
   ```

## Cost

Estimated monthly cost: **~$10-15**
- EC2 t2.micro: ~$8.50/month
- EBS volume: ~$0.80/month
- Free tier eligible: Yes (750 hours/month)
