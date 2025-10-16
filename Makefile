.PHONY: help init validate fmt plan apply destroy clean aws gcp azure all

# Default target
help:
	@echo "Multi-Cloud Terraform Makefile"
	@echo "=============================="
	@echo ""
	@echo "Available targets:"
	@echo "  help          - Show this help message"
	@echo "  init          - Initialize Terraform"
	@echo "  validate      - Validate Terraform configuration"
	@echo "  fmt           - Format Terraform files"
	@echo "  plan          - Show Terraform execution plan"
	@echo "  apply         - Apply Terraform configuration"
	@echo "  destroy       - Destroy Terraform-managed infrastructure"
	@echo "  clean         - Clean Terraform files (.terraform, *.tfstate)"
	@echo ""
	@echo "Cloud-specific targets:"
	@echo "  aws           - Deploy only AWS resources"
	@echo "  gcp           - Deploy only GCP resources"
	@echo "  azure         - Deploy only Azure resources"
	@echo "  aws-destroy   - Destroy only AWS resources"
	@echo "  gcp-destroy   - Destroy only GCP resources"
	@echo "  azure-destroy - Destroy only Azure resources"
	@echo ""
	@echo "Other targets:"
	@echo "  output        - Show Terraform outputs"
	@echo "  refresh       - Refresh Terraform state"
	@echo "  show          - Show current state"
	@echo "  graph         - Generate dependency graph"

# Initialize Terraform
init:
	@echo "Initializing Terraform..."
	terraform init

# Validate Terraform configuration
validate:
	@echo "Validating Terraform configuration..."
	terraform validate
	@echo "Validating AWS module..."
	cd AWS && terraform init -backend=false && terraform validate
	@echo "Validating GCP module..."
	cd GCP && terraform init -backend=false && terraform validate
	@echo "Validating Azure module..."
	cd Azure && terraform init -backend=false && terraform validate
	@echo "All validations passed!"

# Format Terraform files
fmt:
	@echo "Formatting Terraform files..."
	terraform fmt -recursive
	@echo "Formatting complete!"

# Check formatting without making changes
fmt-check:
	@echo "Checking Terraform formatting..."
	terraform fmt -check -recursive

# Show Terraform execution plan
plan:
	@echo "Creating Terraform execution plan..."
	terraform plan

# Apply Terraform configuration
apply:
	@echo "Applying Terraform configuration..."
	terraform apply

# Auto-approve apply (use with caution!)
apply-auto:
	@echo "Applying Terraform configuration (auto-approved)..."
	terraform apply -auto-approve

# Destroy Terraform-managed infrastructure
destroy:
	@echo "Destroying Terraform-managed infrastructure..."
	terraform destroy

# Auto-approve destroy (use with caution!)
destroy-auto:
	@echo "Destroying infrastructure (auto-approved)..."
	terraform destroy -auto-approve

# Deploy only AWS resources
aws:
	@echo "Deploying AWS resources..."
	terraform apply -target=module.aws_resources

# Deploy only GCP resources
gcp:
	@echo "Deploying GCP resources..."
	terraform apply -target=module.gcp_resources

# Deploy only Azure resources
azure:
	@echo "Deploying Azure resources..."
	terraform apply -target=module.azure_resources

# Destroy only AWS resources
aws-destroy:
	@echo "Destroying AWS resources..."
	terraform destroy -target=module.aws_resources

# Destroy only GCP resources
gcp-destroy:
	@echo "Destroying GCP resources..."
	terraform destroy -target=module.gcp_resources

# Destroy only Azure resources
azure-destroy:
	@echo "Destroying Azure resources..."
	terraform destroy -target=module.azure_resources

# Show Terraform outputs
output:
	@echo "Terraform outputs:"
	terraform output

# Refresh Terraform state
refresh:
	@echo "Refreshing Terraform state..."
	terraform refresh

# Show current state
show:
	@echo "Current Terraform state:"
	terraform show

# Generate dependency graph
graph:
	@echo "Generating dependency graph..."
	terraform graph | dot -Tpng > graph.png
	@echo "Graph saved to graph.png"

# Clean Terraform files
clean:
	@echo "Cleaning Terraform files..."
	rm -rf .terraform
	rm -f .terraform.lock.hcl
	rm -f terraform.tfstate
	rm -f terraform.tfstate.backup
	rm -f *.tfplan
	rm -f graph.png
	@echo "Clean complete!"

# Complete workflow: init, validate, plan
check: init validate plan

# Complete workflow: init, validate, apply
deploy: init validate apply

# Quick setup (init + format)
setup: init fmt
	@echo "Setup complete! Run 'make plan' to preview changes."
