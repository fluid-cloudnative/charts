#!/bin/bash
set -e

function main() {
    kubectl create ns fluid-system
    pwd
    helm install --create-namespace fluid charts/charts/fluid
}

main