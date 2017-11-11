#!/usr/bin/env bash

#terraform
curl -fSL "https://releases.hashicorp.com/terraform/0.10.8/terraform_0.10.8_linux_amd64.zip" -o terraform.zip
unzip terraform.zip -d /opt/terraform
sudo ln -s /opt/terraform/terraform /usr/bin/terraform
rm -f terraform.zip

#azure_client
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
     sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893
sudo apt-get install apt-transport-https
sudo apt-get update && sudo apt-get install azure-cli