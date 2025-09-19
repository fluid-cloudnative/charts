#!/bin/bash
set -e

function main() {
    kubectl create ns fluid-system
    helm install --create-namespace fluid charts/fluid/fluid
}

main