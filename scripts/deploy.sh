#!/usr/bin/env bash

pushd stage/global
terraform apply
popd

pushd stage/network
terraform apply
popd
