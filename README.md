# Terraform AWS EC2 Tutorial

Terraform configuration that provisions a single AWS EC2 instance (Ubuntu), a security group, and an SSH key pair, then bootstraps the instance with Nginx via a `user_data` script.

## What it creates

- **EC2 instance** (`instance.tf`) — latest Ubuntu AMI (owner `099720109477`), using a security group and key pair defined in this repo, with Nginx installed on boot.
- **Security group** (`security-group.tf`) — opens the ingress ports listed in `var.ports` (default: 22, 80, 443) to `0.0.0.0/0`, and allows all egress.
- **Key pair** (`key-pair.tf`) — registers a local public key (`id_rsa.pub`) with AWS for SSH access.
- **AMI lookup** (`data_source.tf`) — resolves the most recent Ubuntu AMI matching `var.ami_image_name`.

## File structure

| File | Purpose |
|---|---|
| `provider.tf` | AWS provider configuration (region, credentials) |
| `variable.tf` | Input variable declarations |
| `terraform.tfvars` | Actual variable values (gitignored — contains secrets) |
| `terraform-example.tfvars` | Template showing which variables to fill in |
| `instance.tf` | EC2 instance resource + provisioners |
| `security-group.tf` | Security group and ingress/egress rules |
| `key-pair.tf` | AWS key pair resource |
| `data_source.tf` | Ubuntu AMI data source |
| `script.sh` | `user_data` bootstrap script (installs Nginx) |
| `id_rsa` / `id_rsa.pub` | SSH key pair used to connect to the instance (gitignored) |

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- An AWS account with programmatic access (access key + secret key)
- An SSH key pair for connecting to the instance:
  ```bash
  ssh-keygen -t rsa -b 4096 -f id_rsa -N ""
  ```

## Setup

1. Copy the example vars file and fill in your own values:
   ```bash
   cp terraform-example.tfvars terraform.tfvars
   ```
2. Edit `terraform.tfvars` with your AWS region, access key, secret key, AMI name filter, instance type, instance name, and ports.
3. Make sure `id_rsa` / `id_rsa.pub` exist in this directory (see Prerequisites).

## Usage

```bash
terraform init
terraform plan
terraform apply
```

Terraform will print the instance's public IP (also written to `/tmp/myPublicIp.txt` on the machine running `terraform apply`). Once applied, Nginx should be reachable at `http://<public-ip>`.

To tear everything down:

```bash
terraform destroy
```

## Security notes

- `terraform.tfvars`, `terraform.tfstate*`, `id_rsa`, and `id_rsa.pub` are gitignored since they contain credentials/secrets and instance state. Never commit real values for these.
- The security group opens ports 22/80/443 to the entire internet (`0.0.0.0/0`) — fine for a tutorial, but restrict `cidr_blocks` before using this in anything beyond learning/testing.
- Prefer AWS credentials via environment variables or an AWS CLI profile over hardcoding `access_key`/`secret_key` in `terraform.tfvars` where possible.
