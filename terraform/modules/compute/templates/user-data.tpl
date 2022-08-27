#!/bin/bash
ssh-keyscan -t rsa github.com >> /home/rdpuser/.ssh/known_hosts
cd /home/rdpuser
runuser -l rdpuser -c 'git clone git@github.com:jus-ty/bot_fredrick.git'
whoami
echo "after"
runuser -l rdpuser -c 'whoami'
pwd
##git clone git@github.com:jus-ty/bot_fredrick.git
## SET @reboot CRON HERE?