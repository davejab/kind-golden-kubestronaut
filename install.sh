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

    repo_url=$(yq ".repos[] | select(.name == \"$repo\") | .url" apps.yml)
    [[ -z $repo_url ]] && echo "repo \"$repo\" not found" && exit 1

    existing_url=$(helm repo list -o json | jq -r ".[] | select(.name == \"$repo\") | .url")
    # add helm repository for app
    if [[ -z $existing_url ]]; then
        helm repo add $repo $repo_url
    elif [[ $existing_url != $repo_url ]]; then
        helm repo remove $repo
        helm repo add $repo $repo_url
    fi

    # set up helm args
    helm_args="--install $name $repo/$chart -n $namespace \
                --version $version $extra_args"

    # append values file if it exists
    values_file=$(dirname $0)/values/$name.yml
    [[ -f $values_file ]] && helm_args="$helm_args --values $values_file"

    # append kustomize post render if it exists
    kustom=$(dirname $0)/kustom/$name/
    [[ -d $kustom ]] && helm_args="$helm_args --post-renderer kustomize --post-renderer-args $kustom"

    # run helm install
    helm upgrade $helm_args

    [[ ! "$message" == "null" ]] && echo "" && echo "$message"
}

# install helm kustomize plugin
helm plugin install kustom/ > /dev/null 2>&1

if [[ -z $target_app ]]; then
    # no target app specified, install all apps
    while read -r app; do
        install "$app"
    done <<< "$(yq -o=j . $(dirname $0)/apps.yml | jq -c '.apps[]')"
else
    # extract json payload for target app
    app=$(yq -o=j ".apps[] | select(.name == \"$target_app\")" $(dirname $0)/apps.yml | jq -c)
    [[ -z $app ]] && echo "app \"$target_app\" not found" && exit 1
    install "$app"
fi

echo "---------------------"