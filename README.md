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
./deploy.sh <ENV> <ACTION>

Valid environments: dev, prod
Valid actions: apply, destroy

AWS, Terraform, Python (Lambda), Cloudwatch, maybe a DB