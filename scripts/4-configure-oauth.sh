#!/bin/bash

MY_IP=`curl -s ifconfig.co`

# env flags that need to be set:
CLIENT_ID=myClientId
CLIENT_SECRET=myClientSecret
PROVIDER=google|github|azure
REDIRECT_URI="http://${MY_IP}:8084/login"

set -e

hal config security authn oauth2 edit \
  --client-id $CLIENT_ID \
  --client-secret $CLIENT_SECRET \
  --provider $PROVIDER
hal config security authn oauth2 enable

hal config security authn oauth2 edit --pre-established-redirect-uri $REDIRECT_URI

hal config security ui edit \
    --override-base-url http://${MY_IP}:9000

hal config security api edit \
    --override-base-url http://${MY_IP}:8084
