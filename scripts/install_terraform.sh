curl -fSL "https://releases.hashicorp.com/terraform/0.10.8/terraform_0.10.8_linux_amd64.zip" -o terraform.zip
unzip terraform.zip -d /opt/terraform
ln -s /opt/terraform/terraform /usr/bin/terraform
rm -f terraform.zip
