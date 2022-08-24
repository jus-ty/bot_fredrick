#!/bin/bash
env=$1

cd terraform

terraform init \
-backend-config="bucket=terraform-state-537519792485" \
-backend-config="key=bot_fredrick_$env" \
-backend-config="region=ap-southeast-2" 

terraform plan -var-file="environment/$env/terraform.tfvars"