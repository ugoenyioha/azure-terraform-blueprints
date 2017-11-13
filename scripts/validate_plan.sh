#!/usr/bin/env bash

set -e

echo "Validating Base Environment..."
pushd stage/global/
terraform init  -backend-config="storage_account_name=$AZURE_STORAGE_ACCOUNT_NAME" \
                -backend-config="container_name=$AZURE_CONTAINER_NAME"  \
                -backend-config="key=$AZURE_STAGE_GLOBAL_STATE_KEY" \
                -backend-config="resource_group_name=$AZURE_RESOURCE_GROUP_NAME" \
                -backend-config="access_key=$AZURE_STORAGE_ACCESS_KEY"
terraform plan
popd

echo "Validating Network..."
pushd stage/network/
terraform init  -backend-config="storage_account_name=$AZURE_STORAGE_ACCOUNT_NAME" \
                -backend-config="container_name=$AZURE_CONTAINER_NAME"  \
                -backend-config="key=$AZURE_STAGE_NETWORK_STATE_KEY" \
                -backend-config="resource_group_name=$AZURE_RESOURCE_GROUP_NAME" \
                -backend-config="access_key=$AZURE_STORAGE_ACCESS_KEY"
terraform plan
popd

echo "Validating Services..."
pushd stage/services/frontend-app/
terraform init  -backend-config="storage_account_name=$AZURE_STORAGE_ACCOUNT_NAME" \
                -backend-config="container_name=$AZURE_CONTAINER_NAME"  \
                -backend-config="key=$AZURE_STAGE_APPS_STATE_KEY" \
                -backend-config="resource_group_name=$AZURE_RESOURCE_GROUP_NAME" \
                -backend-config="access_key=$AZURE_STORAGE_ACCESS_KEY"
terraform plan
popd