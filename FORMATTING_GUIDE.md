# Terraform Formatting Guide

## Overview

This project uses automated Terraform formatting checks via GitHub Actions. This ensures consistent code style across all contributors.

## GitHub Actions Workflow

The workflow (`.github/workflows/terraform-validate.yml`) performs the following checks:

1. **Format Check** - Warns if files need formatting (non-blocking)
2. **Validation** - Validates Terraform syntax and configuration
3. **Security Scan** - Runs tfsec for security issues
4. **Markdown Lint** - Checks documentation formatting

## How to Fix Formatting Issues

If you see a formatting warning in GitHub Actions, you have several options:

### Option 1: Using Terraform CLI (Recommended)

```bash
# Format all .tf files recursively
terraform fmt -recursive

# Check formatting without making changes
terraform fmt -check -recursive

# Show formatting differences
terraform fmt -check -recursive -diff
```

### Option 2: Using Makefile

```bash
# Format all files
make fmt

# Check formatting (no changes)
make fmt-check
```

### Option 3: Using VS Code Extension

1. Install the [Terraform extension](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
2. Enable format on save in VS Code settings:
   ```json
   {
     "[terraform]": {
       "editor.formatOnSave": true
     }
   }
   ```

## Terraform Formatting Rules

Terraform's `fmt` command applies the following rules:

- **Indentation**: 2 spaces (not tabs)
- **Alignment**: Aligns equals signs in consecutive assignments
- **Quotes**: Normalizes quote usage
- **Spacing**: Removes unnecessary blank lines and trailing whitespace

### Examples

#### Before Formatting:
```hcl
resource "aws_instance" "example"{
  ami="ami-123456"
instance_type    = "t2.micro"


  tags={
    Name= "example"
  }
}
```

#### After Formatting:
```hcl
resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = "t2.micro"

  tags = {
    Name = "example"
  }
}
```

## Pre-Commit Setup (Optional)

To automatically format files before committing, you can set up a pre-commit hook:

### Using Git Hooks

Create `.git/hooks/pre-commit`:

```bash
#!/bin/sh
# Format Terraform files before commit

echo "Running terraform fmt..."
terraform fmt -recursive

# Add formatted files back to the commit
git add -u
```

Make it executable:
```bash
chmod +x .git/hooks/pre-commit
```

### Using pre-commit Framework

1. Install pre-commit:
   ```bash
   pip install pre-commit
   ```

2. Create `.pre-commit-config.yaml`:
   ```yaml
   repos:
     - repo: https://github.com/antonbabenko/pre-commit-terraform
       rev: v1.83.5
       hooks:
         - id: terraform_fmt
         - id: terraform_validate
   ```

3. Install the hooks:
   ```bash
   pre-commit install
   ```

## CI/CD Workflow Behavior

### Current Behavior (Non-Blocking)

The format check currently **warns** but does **not fail** the workflow. This allows:
- New contributors to learn formatting gradually
- Focus on functionality over style initially
- Security and validation checks to always run

### Making Format Check Blocking (Optional)

To make formatting a hard requirement, update `.github/workflows/terraform-validate.yml`:

```yaml
- name: Terraform Format Check
  id: fmt
  run: terraform fmt -check -recursive -diff
  continue-on-error: false  # Change this to false to make it blocking
```

Then add a failure step:

```yaml
- name: Fail if formatting needed
  if: steps.fmt.outcome == 'failure'
  run: |
    echo "❌ Terraform formatting check failed!"
    echo "Please run 'terraform fmt -recursive' to fix."
    exit 1
```

## Troubleshooting

### "terraform: command not found"

**Solution**: Install Terraform locally:

- **Windows**: 
  ```powershell
  choco install terraform
  ```
  Or download from [terraform.io](https://www.terraform.io/downloads)

- **macOS**:
  ```bash
  brew install terraform
  ```

- **Linux**:
  ```bash
  # Ubuntu/Debian
  wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update && sudo apt install terraform
  ```

### Format Check Still Failing in CI

If the format check fails even after running `terraform fmt -recursive`:

1. **Verify your Terraform version**:
   ```bash
   terraform version
   ```
   Should be >= 1.0

2. **Check for hidden files**:
   ```bash
   # Check all .tf files
   find . -name "*.tf" -type f
   ```

3. **Run format with verbose output**:
   ```bash
   terraform fmt -recursive -diff
   ```

4. **Check line endings** (Windows vs Unix):
   ```bash
   # Convert to Unix line endings if needed
   dos2unix **/*.tf
   ```

## Best Practices

1. **Format before committing**: Always run `terraform fmt -recursive` before pushing
2. **Use editor integration**: Set up VS Code or your IDE to format on save
3. **Review diffs**: Check what `terraform fmt` changed before committing
4. **Consistent style**: Follow Terraform's canonical style guide
5. **Automate locally**: Use pre-commit hooks to catch issues early

## Additional Resources

- [Terraform Style Guide](https://www.terraform.io/docs/language/syntax/style.html)
- [terraform fmt Documentation](https://www.terraform.io/docs/cli/commands/fmt.html)
- [VS Code Terraform Extension](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)

---

**Note**: The GitHub Actions workflow currently treats formatting as a **warning**, not an error. This is intentional to make the repository more accessible while still maintaining code quality through other checks (validation and security scanning).

If you want to enforce strict formatting, see the "Making Format Check Blocking" section above.
