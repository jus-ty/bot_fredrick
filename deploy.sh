#!/bin/bash
env=${1,,}
action=${2,,}

# Parameter validation: env
if [ "$env" == "dev" ]; then
    echo "Development Environment selected!"
elif [ "$env" == "prod" ]; then
    echo "Production Environment selected!"
else
    echo "Invalid environment selected. Must be one of 'dev' or 'prod'"
    exit
fi

# Parameter validation: action
if [ "$action" == "apply" ]; then
    echo "Apply action selected!"
elif [ "$action" == "destroy" ]; then
    echo "Destroy action selected!"
else
    echo "Invalid action selected. Must be one of 'apply' or 'destroy'"
    exit
fi

# Get branch name
branch_name=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

name="bot_fredrick_$env"

cd terraform

terraform init -reconfigure \
-backend-config="bucket=terraform-state-537519792485" \
-backend-config="key=$name" \
-backend-config="region=ap-southeast-2"

terraform workspace select $name || terraform workspace new $name

terraform plan -var-file="environment/$env/terraform.tfvars" -var "git_branch=$branch_name"
terraform $action -var-file="environment/$env/terraform.tfvars" -var "git_branch=$branch_name"