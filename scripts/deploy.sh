#!/usr/bin/env bash

set -e

echo "Deploying Base Environment...."
pushd stage/global
terraform apply
popd

echo "Deploying Network...."
pushd stage/network
terraform apply
popd

echo "Deploying Services...."
pushd stage/services/frontend-app/
terraform apply
popd

echo "Deploying Container Registry...."
pushd stage/services/container-registry/
terraform apply
popd