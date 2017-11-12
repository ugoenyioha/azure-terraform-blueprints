#!/usr/bin/env bash

echo "Validating Base Environment..."
pushd stage/global/
terraform init -backend-config="storage_account_name=${AZURE_STORAGE_ACCOUNT_NAME}" \
             -backend-config="container_name=${AZURE_CONTAINER_NAME}"  \
             -backend-config="key=${AZURE_STATE_KEY}" \
             -backend-config="resource_group_name=${AZURE_RESOURCE_GROUP_NAME}" \
             -backend-config="access_key=${AZURE_STORAGE_ACCESS_KEY}"
terraform plan
popd

echo "Validating Network..."
pushd stage/network/
terraform init -backend-config="storage_account_name=${AZURE_STORAGE_ACCOUNT_NAME}" \
             -backend-config="container_name=${AZURE_CONTAINER_NAME}"  \
             -backend-config="key=${AZURE_STATE_KEY}" \
             -backend-config="resource_group_name=${AZURE_RESOURCE_GROUP_NAME}" \
             -backend-config="access_key=${AZURE_STORAGE_ACCESS_KEY}"
terraform plan
popd