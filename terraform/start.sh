#!/bin/bash

terraform init -input=false

terraform apply -input=false -auto-approve

url=$(terraform output -raw timestamp_loadbalancer)

until $(curl --output /dev/null --silent --fail "$url:8080/timestamp"); do
    printf '.'
    sleep 5
done

echo
curl $url:8080/timestamp
echo
echo "URL: $url:8080/timestamp"
echo
