# Terraform Blueprint for Azure

How to use

## Local
    1. Authenticate to Azure using the Azure CLI
    https://www.terraform.io/docs/providers/azurerm/authenticating_via_azure_cli.html
    
    2. packer build stage/images/windows.json  (you may have to uppdate credentials)
    
    3. terraform init: stage/global, stage/network, stage/services/frontend-app
    
    4. terraform apply: stage/global, stage/network, stage/services/frontend-app
    
## Unattended / CICD
    1. Authenticate to Azure via Service Principal
    https://www.terraform.io/docs/providers/azurerm/authenticating_via_service_principal.html
    
    2. packer build stage/images/windows.json (you may have to uppdate credentials)
    
    3. terraform init: stage/global, stage/network, stage/services/frontend-app
    
    4. terraform apply: stage/global, stage/network, stage/services/frontend-app
    
## Features
    - Deploys a simple Windows VM behind a load balancer.
        - The VM is built via with packer
    
## Todo
    - Better parametization
    - Deployment pipeline
    - Better start-up automation
    - Bastion Host
    - Change to Petshop Linux Microservices built via packcer
    - Add authentication to Petshop
    - Deploy to ACS