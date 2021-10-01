#!/bin/bash

print_header(){
  dashes="===================================================="
  echo ""
  echo "$dashes"
  echo "  $1"
  echo "$dashes"
  echo ""
}
print_header "Creating Minecraft server"

print_header "Initializing Terraform files"
cd Terraform || exit 1
terraform init || { echo 'Failed while initializing terraform configuration '; exit 1; }

print_header "Validating Terraform files"
terraform validate || { echo 'Failed while validating terraform configuration '; exit 1; }


print_header "Provisioning AWS resources with Terraform"
# terraform apply || { echo 'Failed while applying terraform configuration '; exit 1; }


print_header "Adding server IP to ansible inventory file"

print_header "Running Ansible playbook on remote server"
cd ../ || exit 1
exit 1
ansible-playbook ansible/playbook.yaml -i ansible/hosts -K

print_header "Server successfully configured"

exit 0