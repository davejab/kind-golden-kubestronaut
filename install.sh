#!/usr/bin/env bash

target_app=""
extra_args="--create-namespace"

# parse args
#   -w          wait for resources to be ready
#   -q          hide helm notes
#   -a <app>    target specific app
while getopts wqa: flag
do
    case "${flag}" in
        w) extra_args="$extra_args --wait";;
        q) extra_args="$extra_args --hide-notes";;
        a) target_app=${OPTARG};;
    esac
done
shift $((OPTIND - 1))

# install given application, expects json payload with app details
install() {
    app=$1
    echo "---------------------"

    # extract app details from json payload
    name=$(echo $app | jq -r '.name')
    namespace=$(echo $app | jq -r '.namespace')
    repo=$(echo $app | jq -r '.repo')
    chart=$(echo $app | jq -r '.chart')
    version=$(echo $app | jq -r '.version')
    message=$(echo $app | jq -r '.message')

    # add helm repository for app
    helm repo add $name $repo

    # set up helm args
    helm_args="--install $name $name/$chart -n $namespace \
                --version $version $extra_args"

    # append values file if it exists
    values_file=$(dirname $0)/values/$name.yml
    [[ -f $values_file ]] && helm_args="$helm_args --values $values_file"

    # run helm install
    helm upgrade $helm_args

    [[ ! "$message" == "null" ]] && echo "" && echo "$message"

    # apply additional manifests if they exist
    manifests=$(dirname $0)/manifests/$name/
    [[ -d $manifests ]] && kubectl apply -f $manifests
}

if [[ "$target_app" == "" ]]; then
    # no target app specified, install all apps
    while read -r app; do
        install "$app"
    done <<< "$(yq -o=j . $(dirname $0)/apps.yml | jq -c '.apps[]')"
else
    # extract json payload for target app
    app=$(yq -o=j ".apps[] | select(.name == \"$target_app\")" $(dirname $0)/apps.yml | jq -c)
    [[ "$app" == "" ]] && echo "app \"$target_app\" not found" && exit 1
    install "$app"
fi

echo "---------------------"