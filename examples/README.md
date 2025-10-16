# Multi-Cloud Terraform Examples

This directory contains example configurations demonstrating different deployment scenarios.

## 📁 Available Examples

### 1. **Single Cloud Deployments**
- `aws-only/` - Deploy only to AWS
- `gcp-only/` - Deploy only to GCP
- `azure-only/` - Deploy only to Azure

### 2. **Dual Cloud Deployments**
- `aws-gcp/` - Deploy to AWS and GCP
- `aws-azure/` - Deploy to AWS and Azure
- `gcp-azure/` - Deploy to GCP and Azure

### 3. **Full Deployment**
- `all-clouds/` - Deploy to all three cloud providers

## 🚀 How to Use Examples

Each example directory contains:
- `main.tf` - Terraform configuration
- `variables.tf` - Variable definitions
- `README.md` - Specific instructions
- `terraform.tfvars.example` - Example variable values

### Quick Start

1. Navigate to the example directory:
   ```bash
   cd examples/aws-only
   ```

2. Copy and edit the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your values
   ```

3. Initialize and deploy:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## 💡 Example Selection Guide

| Use Case | Example | Cost (Monthly) |
|----------|---------|----------------|
| AWS only | `aws-only/` | ~$10-15 |
| GCP only | `gcp-only/` | ~$7-12 |
| Azure only | `azure-only/` | ~$13-18 |
| AWS + GCP | `aws-gcp/` | ~$17-27 |
| AWS + Azure | `aws-azure/` | ~$23-33 |
| GCP + Azure | `gcp-azure/` | ~$20-30 |
| All clouds | `all-clouds/` | ~$30-45 |

## 📚 Learning Path

**Beginners**: Start with single-cloud examples
1. Try `aws-only/` first (most common)
2. Then try `gcp-only/` or `azure-only/`
3. Graduate to dual-cloud deployments

**Intermediate**: Explore dual-cloud scenarios
1. Try `aws-gcp/` for hybrid cloud
2. Experiment with different combinations

**Advanced**: Full multi-cloud deployment
1. Deploy `all-clouds/` example
2. Customize for your specific needs

## 🔧 Customization

All examples use the same module structure from the parent directory:
- `../AWS/` - AWS module
- `../GCP/` - GCP module
- `../Azure/` - Azure module

You can modify any example by:
1. Changing variables in `terraform.tfvars`
2. Adding/removing modules in `main.tf`
3. Adjusting resource configurations

## ⚠️ Important Notes

- Each example can be deployed independently
- Remember to run `terraform destroy` when done to avoid costs
- Free tier eligibility varies by cloud provider
- Examples use minimal resources to keep costs low

## 🆘 Getting Help

If you encounter issues:
1. Check the example's `README.md`
2. Review the main project [README](../README.md)
3. Check [QUICKSTART guide](../QUICKSTART.md)
4. Open an issue on GitHub
