#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# create self-signed certificate
DOMAIN=k8s.localdev

if test -f "$DOMAIN+1-key.pem"; then
  echo "File $DOMAIN+1-key.pem already exists"
else
  echo "File $DOMAIN+1-key.pem does not exist"
  mkcert $DOMAIN "*.$DOMAIN"
fi

# create ingress-certs secret
SECRET_NAME=ingress-certs

for ns in default ingress-nginx; do

  # create namespace if not exists
  if kubectl get namespace $ns >/dev/null 2>&1; then
    echo "Namespace $ns already exists"
  else
    kubectl create namespace $ns
  fi

  kubectl create secret tls $SECRET_NAME \
    --key $DOMAIN+1-key.pem \
    --cert $DOMAIN+1.pem \
    --namespace $ns \
    --dry-run=client \
    -o yaml | kubectl apply -f -

done

kustomize build "$SCRIPT_DIR/addons/helm-controller" | kubectl apply -f -
kustomize build "$SCRIPT_DIR/addons/ingress-nginx" | kubectl apply -f -