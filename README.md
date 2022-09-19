# infrastructure_as_code_terraform
Terraform is an open-source infrastructure as code software tool that enables you to safely and predictably create, change, and improve infrastructure.

## Commands
# Prepare your working directory for other commands
terraform init

# Check whether the configuration is valid
terraform validate

# Show changes required by the current configuration of vpc resource
terraform plan -target=module.vpc_module

# Show changes required by the current configuration
terraform plan

# Create or update infrastructure
terraform apply

# Create or update infrastructure with auto-approve
terraform apply -auto-approve

# Show output values from your root module
terraform output

# Destroy previously-created infrastructure (Staging environment)
terraform destroy -var-file=staging.tfvars

## Module wise commands (Staging environment)

# VPC
terraform plan -target=module.vpc_module -var-file=staging.tfvars && terraform apply -var-file=staging.tfvars