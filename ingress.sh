#!/usr/bin/env bash

# print out available ingress routes
while read -r ingress; do
    name=$(echo $ingress | jq -r '.metadata.name')
    ip=$(echo $ingress | jq -r '.status.loadBalancer.ingress[0].ip')
    path=$(echo $ingress | jq -r '.spec.rules[0].http.paths[0].path')
    echo "$name - http://${ip}$path"
done <<< "$(kubectl get ingress -o json -A | jq -c '.items[]')"