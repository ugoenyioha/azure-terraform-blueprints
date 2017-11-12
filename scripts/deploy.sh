#!/usr/bin/env bash

echo "Deploying Base Environment...."
pushd stage/global
terraform apply
popd

echo "Deploying Network...."
pushd stage/network
terraform apply
popd
