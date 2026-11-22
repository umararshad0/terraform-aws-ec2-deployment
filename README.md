# AWS EC2 Web Server Deployment with Terraform

## Overview

This project provisions an Ubuntu EC2 web server and security group with Terraform, then serves a simple website through Apache. It demonstrates infrastructure as code, AWS networking, Linux administration, and deployment review.

## Architecture

- AWS provider in a configurable region
- Ubuntu EC2 instance (`t3.micro`)
- Public subnet with an Internet Gateway and route table
- Security group allowing HTTP from the internet and SSH from one trusted IPv4 address
- 8 GB encrypted `gp3` root volume

![AWS EC2 Terraform Architecture](docs/architecture.png)

## Configure

1. Install Terraform and configure AWS credentials with appropriately scoped IAM permissions.
2. Copy `terraform.tfvars.example` to `terraform.tfvars`.
3. Set the region, trusted SSH address as a `/32`, a valid AMI and subnet in that region, and an existing EC2 key-pair name.
4. Keep `terraform.tfvars`, private keys, AWS credentials, and Terraform state files out of Git. The local `.gitignore` excludes them.

## Deploy

```sh
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
```

Review the plan before applying. After deployment, use `terraform output` for the instance ID, public address, and security group ID. Connect to the instance over SSH, install Apache, and deploy the website to `/var/www/html/index.html`.

SSH ingress validation requires one trusted `/32` address. HTTP is open to `0.0.0.0/0` for the public website. Use a trusted TLS certificate and HTTPS before handling real traffic.

## Screenshots

![Website running on AWS EC2](docs/screenshots/live-website.png)

![Terraform output showing deployed infrastructure](docs/screenshots/terraform-output.png)

![AWS EC2 instance details](docs/screenshots/terraform-running.png)

## Troubleshooting experience

During deployment, SSH connectivity failed because the VPC's default route referenced a detached Internet Gateway. Attaching the existing Internet Gateway restored the route and SSH connectivity.

## Cleanup

When the environment is no longer needed, run `terraform plan -destroy`, review the resources carefully, and run `terraform destroy` only after confirming the plan. AWS resource availability, pricing, AMIs, subnet IDs, and permissions vary by region and account.

## Repository

[View the project on GitHub](https://github.com/umararshad0/terraform-aws-ec2-deployment)
