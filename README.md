# bot_fredrick
Automate organisation of badminton sessions

### Setup virtual env
```
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

### Linting
- pylint

### Running terraform deployment
```
./deploy.sh (ENV) (ACTION)
```
- Valid environments: dev, prod
- Valid actions: apply, destroy

e.g ./deploy.sh dev apply

### Terraform module naming standard

Modules should be named based on on AWS Service Categories

### AWS Resources created outside of the terraform scripts (manually)
- S3 Terraform state bucket
- AWS SSM Params (not created yet)