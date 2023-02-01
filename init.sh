#!/usr/bin/env bash

source ./headlesschromium_version.config

rm -f conf.config

# Region Selection
echo 'Please select a number from the AWS region list:'
sleep 2
nl region.list
count="$(wc -l region.list | cut -f 1 -d' ')"
n=""
while true; do
    read -p 'Enter number (e.g 3 for us-west-1): ' n
    # If $n is an integer between one and $count...
    if [ "$n" -eq "$n" ] && [ "$n" -gt 0 ] && [ "$n" -le "$count" ]; then
        break
    fi
done
aws_region="$(sed -n "${n}p" region.list)"
echo -e "The user selected option number $n: '$aws_region'\n"

echo "aws_region=${aws_region}" >> conf.config

# Service account email address
account_email=""
read -p 'Enter the email address for your facebook service account (e.g johndoe@email.com): ' account_email
echo "account_email=${account_email}" >> conf.config

# Service account password
account_password=""
read -p 'Enter the password for your facebook service account: ' account_password
echo "account_password=${account_password}" >> conf.config

# Dev thread IDs
thread_id_dev=""
read -p 'Enter the thread ID for your dev chat: ' thread_id_dev
echo "thread_id_dev=${thread_id_dev}" >> conf.config

# Prod thread IDs
thread_id_prod=""
read -p 'Enter the thread ID for your prod chat: ' thread_id_prod
echo "thread_id_prod=${thread_id_prod}" >> conf.config

# # Terraform state bucket creation
byo_state_bucket=${1,,}

account_number=$(aws sts get-caller-identity --query Account --output text)
echo "account_number=${account_number}" >> conf.config

if [ -z "$byo_state_bucket" ]; then
    state_bucket_name="terraform-state-${account_number}"
    aws s3 mb "s3://${state_bucket_name}" --region "${aws_region}"
else
    state_bucket_name="${byo_state_bucket}"
fi

echo "state_bucket_name=${state_bucket_name}" >> conf.config

# headless-chrome-aws-lambda-layer: Download and move

# NOTE: Ensure git is configured!!

wget https://github.com/diegoparrilla/headless-chrome-aws-lambda-layer/archive/refs/tags/${headlesschromium_version}.zip
mv ${headlesschromium_version}.zip ./terraform/modules/compute/src/layers

echo "headlesschromium_version=${headlesschromium_version}" >> conf.config
