#!/usr/bin/env bash

set -e

#terraform
curl -fSL "https://releases.hashicorp.com/terraform/0.11.1/terraform_0.11.1_linux_amd64.zip" -o terraform.zip
unzip terraform.zip -d /opt/terraform
sudo ln -s /opt/terraform/terraform /usr/bin/terraform
rm -f terraform.zip
