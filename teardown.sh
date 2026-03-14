#!/usr/bin/env bash

# kill cloud-provider-kind process
pgrep cloud-provider-kind | xargs sudo kill

# delete kind cluster
cluster_name=$(yq .name $(dirname $0)/config.yml)
kind delete cluster --name $cluster_name