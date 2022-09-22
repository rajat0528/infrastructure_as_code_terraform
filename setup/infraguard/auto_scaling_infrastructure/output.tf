output "vpc_output" {
  description = "VPC module output"
  value       = module.vpc_module
}

output "subnets_output" {
  description = "Subnets module output"
  value       = module.subnet_module
}