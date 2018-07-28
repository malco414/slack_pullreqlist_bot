#!/bin/bash

#-----------------------------------------------
# VARIABLES
#-----------------------------------------------
SCRIPT_DIR=$(cd $(dirname $(readlink -f $0 || echo $0));pwd -P)
source ./variables.txt
SLACK_BOT_NAME="プルリクくん"
SLACK_CHANNEL="#pullreq_bot"
#-----------------------------------------------
# MAIN
#-----------------------------------------------

### GET REPO LIST
#for l in `curl -s -H "Authorization: token ${TOKEN}" https://api.github.com/users/malco414/repos?per_page=100 | \
# jq .[].pulls_url -r | cut -d'{' -f1`; do echo $l ; curl -s  -H "Authorization: token ${TOKEN}" $l | jq .[].title; done

### GET PR LIST


 ### POST
curl -X POST --data-urlencode "payload={\"channel\": \"${SLACK_CHANNEL}\", \"username\": \"${SLACK_BOT_NAME}\", \"text\": \"テスト\", \"icon_emoji\": \":bug:\"}" ${WEBHOOKURL}

