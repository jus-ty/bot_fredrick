# bot_fredrick
Automate organisation of badminton sessions

<p><img align="center" alt="GIF" src="https://github.com/jus-ty/bot_fredrick/blob/main/baddy.gif" width="500" height="350" /></p>

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


### AWS Architecture Diagram

<p><img align="center" alt="arch diagram" src="https://github.com/jus-ty/bot_fredrick/blob/feature/better_params_and_nat_savings/botfredrickdiagram.png"/></p>

### AWS Resources created outside of the terraform scripts (manually)
- S3 Terraform state bucket
- AWS SSM Params
- Lambda Chromedriver layer (https://github.com/diegoparrilla/headless-chrome-aws-lambda-layer, version: v0.2-beta.0)
