# bot_fredrick
Automate organisation of badminton sessions

<p><img align="center" alt="GIF" src="https://github.com/jus-ty/bot_fredrick/blob/main/baddy.gif" width="500" height="350" /></p>

### Setup
1. Complete region selection, parameter inputs and terraform state bucket creation by running ./init.sh
    - If you already have a terraform state bucket in your account and wish to use that one:
        - Run ./init.sh <<STATE_BUCKET_NAME>>

2. Run:
```
./deploy.sh (ENV) (ACTION)
```
- Valid environments: dev, prod
- Valid actions: apply, destroy

e.g ./deploy.sh dev apply

3. Scheduling the create_poll lambda:
- Navigate to terraform/environment/(env*)/terraform.tfvars
    - Select when the create_poll lambda should run with: create_poll_event_bridge_schedule
    - Select when the NAT instance starts up with: start_instance_schedule (Should ideally be 5 minutes before create_poll_event_bridge_schedule)
    - Select when the NAT instance stops with: stop_instance_schedule (Should ideally be 5 minutes after create_poll_event_bridge_schedule)
*: Depending on your selected environment

### Virtual env setup
```
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

### Linting
- pylint

### Terraform module naming standard

Modules should be named based on on AWS Service Categories


### AWS Architecture Diagram

<p><img align="center" alt="arch diagram" src="https://github.com/jus-ty/bot_fredrick/blob/main/botfredrickdiagram.png"/></p>

<i>EDIT 2023/02/04: NAT Gateway was converted to a NAT Instance, GW is way too much $$$$</i>
