#!/bin/sh


icLogin () {
  echo "logon to ibmcloud"
  echo "ic login -a ${IC_ENDPOINT} -c ${IC_ACCOUNT_ID} -p XXXXXXXXXX"
  ic login --apikey ${IC_API_KEY}
}


waitForWorkspaceToInactive() {
    ws_id=$1
    while :
    do
        #sleep for 10s
        sleep 10s
        status=$(ic terraform workspace get --id $ws_id | grep Status | awk '{print $2}')
        echo "verifying the status of workspace. Current status is $status"
        if [[ $status == "INACTIVE" ]]; then
            return 0
        elif [[ $status == "FAILED" ]]; then
            exit 1
        fi
    done
}

ws_id=`cat test`

icLogin ${IC_API_KEY}

ic terraform destroy --id $ws_id  --force

waitForWorkspaceToInactive $ws_id

ic terraform workspace delete --id $ws_id --force

rm -rf test
