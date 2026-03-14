#!/usr/bin/env bash

# install cloud-provider-kind
go install sigs.k8s.io/cloud-provider-kind@latest

# init kind cluster
kind create cluster --config $(dirname $0)/config.yml

# run cloud-provider-kind in background
sudo bash -c 'cloud-provider-kind > /dev/null 2>&1 &'