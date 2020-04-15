#!/bin/sh

icLogin () {
  echo "logon to ibmcloud"
  echo "ic login -a ${IC_ENDPOINT} -c ${IC_ACCOUNT_ID} -p XXXXXXXXXX"
  ic login --apikey ${IC_API_KEY}
}

icLogin ${IC_API_KEY}

ws_id=$(ic terraform workspace new --file test.json | grep ID | awk '{print $2}')
echo  $ws_id > test
sleep 20s

ic terraform apply --id $ws_id  --force
