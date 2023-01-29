#!/bin/bash

function install_prerequisites() {
    kubectl apply -k prerequisites
}

function install_traefik() {
    local stage=$1
    echo "stage: ${stage}"
    kubectl kustomize base --enable-helm | kubectl apply -f -
}

function get_http_node_port() {
    kubectl get svc -n traefik traefik -o jsonpath="{.spec.ports[?(@.name=='web')].nodePort}"
}

case $1 in
  "install")
    install_prerequisites
    install_traefik    
    ;;
  "get_port")
    get_http_node_port
    ;;
   *) echo "usage: deploy [install|get_port]" ;;
esac


