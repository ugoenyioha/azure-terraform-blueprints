curl -sLo "https://releases.hashicorp.com/terraform/0.10.8/terraform_0.10.8_linux_amd64.zip" -o terraform.zip
sudo unzip terraform.zip -d /opt/terraform
sudo ln -s /opt/terraform/terraform /usr/bin/terraform
rm -f terraform.zip