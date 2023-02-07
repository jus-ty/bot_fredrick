#!/usr/bin/env bash
env=${1,,}
action=${2,,}

source ./conf.config

# Parameter validation: env
if [ "$env" == "dev" ]; then
    echo "Development Environment selected!"
    thread_id="$thread_id_dev"
elif [ "$env" == "prod" ]; then
    echo "Production Environment selected!"
    thread_id="$thread_id_prod"
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
-backend-config="bucket=$state_bucket_name" \
-backend-config="key=$name" \
-backend-config="region=$aws_region"

terraform workspace select $name || terraform workspace new $name

terraform plan -var-file="environment/$env/terraform.tfvars" -var "git_branch=$branch_name" -var "aws_region=$aws_region" -var "account_email=$account_email" -var "account_password=$account_password" -var "thread_id=$thread_id" -var "headlesschromium_version=$headlesschromium_version" -var "state_bucket_name=$state_bucket_name"
terraform $action -var-file="environment/$env/terraform.tfvars" -var "git_branch=$branch_name" -var "aws_region=$aws_region" -var "account_email=$account_email" -var "account_password=$account_password" -var "thread_id=$thread_id" -var "headlesschromium_version=$headlesschromium_version" -var "state_bucket_name=$state_bucket_name"