#!/bin/bash
#set -ex

status_code=$(curl --write-out %{http_code} --silent --output /dev/null --include \
     --request POST \
     --header "Content-Type: application/json; charset=utf-8" \
     --header "Authorization: Basic ${onesignal_rest_api_key}" \
     --data-binary "{\"app_id\": \"${onesignal_app_id}\",
\"contents\": {\"en\": \"${onesignal_message}\"},
\"filters\": [{\"field\": \"tag\", \"key\": \"${onesignal_tag_name}\", \"relation\": \"${onesignal_tag_relation}\", \"value\": \"${onesignal_tag_value}\"}]}" \
     https://onesignal.com/api/v1/notifications)
if [[ $status_code -eq 200 ]] ; then
  echo "OneSignal Push Sent"
  exit 0
else
  echo "OneSignal Push Failed"
  exit -1
fi
