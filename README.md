# DBA_IaC

This repository contains an example of using Terraform and Ansible to deploy
SQL Server 2022 Developer Edition on an Azure virtual machine.

## Terraform

The `terraform` directory creates the Azure infrastructure including:

- Resource group
- Virtual network and subnet
- Network security group allowing SQL traffic
- Public IP and network interface
- Windows VM preloaded with SQL Server 2022 Developer Edition

Example usage:

```bash
cd terraform
terraform init
terraform apply \
  -var "resource_group_name=myrg" \
  -var "admin_username=azureuser" \
  -var "admin_password=Passw0rd!" \
  -auto-approve
```

## Ansible

The `ansible` directory contains a playbook to configure SQL Server with the
following settings:

- Max server memory set to 90% of available RAM
- `max degree of parallelism` set to 4
- `cost threshold for parallelism` set to 50
- Eight `tempdb` data files

Update `inventory.ini` with the public IP from the Terraform output and run:

```bash
ansible-playbook -i inventory.ini configure_sql.yml
```
