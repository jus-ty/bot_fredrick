# bot_fredrick
Automate organisation of badminton sessions

![hippo](https://media3.giphy.com/media/TjAA9nsULA3NHco0dI/giphy.gif?cid=790b7611217f5c1883757d41ea5bf18e2e198919fba41745&rid=giphy.gif&ct=g)


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
- AWS SSM Params
- Lambda Chromedriver layer (https://github.com/diegoparrilla/headless-chrome-aws-lambda-layer, version: v0.2-beta.0)
