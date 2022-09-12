# infrastructure_as_code_terraform
Terraform is an open-source infrastructure as code software tool that enables you to safely and predictably create, change, and improve infrastructure.

##Commands
#Prepare your working directory for other commands
terraform init

#Check whether the configuration is valid
terraform validate

#Show changes required by the current configuration
terraform plan -target=module.rds_module

#Show changes required by the current configuration of specific resource
terraform plan

#Create or update infrastructure
terraform apply

#Create or update infrastructure with auto-approve
terraform apply -auto-approve

#Destroy previously-created infrastructure
terraform destroy
