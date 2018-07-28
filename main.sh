#!/bin/bash
#-----------------------------------------------
# VARIABLES
#-----------------------------------------------
SCRIPT_DIR=$(cd $(dirname $(readlink -f $0 || echo $0));pwd -P)
source ${SCRIPT_DIR}/variables.txt
SLACK_BOT_NAME="プルリク通知くん"
SLACK_CHANNEL="#pullreq_bot"
TMP=${SCRIPT_DIR}/tmp.txt
#-----------------------------------------------
# MAIN
#-----------------------------------------------

### CREATE TMP FILE
touch ${TMP}
echo "プルリク一覧を確認しましょう。" >>${TMP}
echo "----" >> ${TMP}

### GET LIST
for l in `curl -s -H "Authorization: token ${TOKEN}" \
  https://api.github.com/users/malco414/repos?per_page=100 \
  | jq .[].pulls_url -r | cut -d'{' -f1`;
  do
    curl -s -H "Authorization: token ${TOKEN}" $l \
    | jq -r '.[] | .head.repo.name, .title, .html_url' >> ${TMP}
  done

### POST
curl -X POST --data-urlencode "payload={\"channel\": \"${SLACK_CHANNEL}\", \"username\": \"${SLACK_BOT_NAME}\", \"text\": \"`cat ${TMP}`\", \"icon_emoji\": \":bug:\"}" ${WEBHOOKURL} >/dev/null 2>&1

### REMOVE TMP FILE
rm -f  ${TMP} >/dev/null 2>&1