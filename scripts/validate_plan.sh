#!/usr/bin/env bash

pushd stage/global/
terraform init -backend-config="storage_account_name=${STORAGE_ACCOUNT_NAME}" \
             -backend-config="container_name=${CONTAINER_NAME}"  \
             -backend-config="key=${STATE_KEY}" \
             -backend-config="resource_group_name=${RESOURCE_GROUP_NAME}" \
             -backend-config="access_key=${STORAGE_ACCESS_KEY}"
terraform plan
popd

pushd stage/network/
terraform init -backend-config="storage_account_name=${STORAGE_ACCOUNT_NAME}" \
             -backend-config="container_name=${CONTAINER_NAME}"  \
             -backend-config="key=${STATE_KEY}" \
             -backend-config="resource_group_name=${RESOURCE_GROUP_NAME}" \
             -backend-config="access_key=${STORAGE_ACCESS_KEY}"
terraform plan
popd