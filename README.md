# bot_fredrick
Automate organisation of badminton sessions

Linting: pylint

# Pre-req installs:
- sudo apt-get install python3-tk python3-dev scrot

# Setup virtual env
- python3 -m venv env
- source env/bin/activate
- pip install -r requirements.txt

# Running terraform deployment
./deploy.sh (ENV) (ACTION)
- Valid environments: dev, prod
- Valid actions: apply, destroy

e.g ./deploy.sh dev apply

# Terraform module naming standard

Modules should be named based on on AWS Service Categories

AWS, Terraform, Python (Lambda), Cloudwatch, maybe a DB