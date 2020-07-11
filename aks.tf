provider "azurerm" {
  version =  "~> 2.18"
  
client_id = "4aa4edf1-b7a2-4718-b12d-207802db30ca"
client_secret = "JBsa-QdcTmg7PCG5hC2xwCxvvwcPA-sfpY"
tenant_id = "2b6d0a61-dfad-4b8b-8763-0cb831697a57"
subscription_id = "64b70538-bc40-4492-9c4b-13f8b43e732d"


  features {}
}

resource "azurerm_resource_group" "azkubernetes" {
  name     = "azkubernetes"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "gitops-demo-aks"
  location            = azurerm_resource_group.azkubernetes.location
  resource_group_name = azurerm_resource_group.azkubernetes.name
  dns_prefix          = "gitlab"

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_F2s_v2"
    os_disk_size_gb = 30
  }
  
  identity {
    type = "SystemAssigned"
    }

  tags = {
    Terraform = "True"
  }
  
  output "env-dynamic-url" {
     value = azurerm_kubernetes_cluster.aks.kube_config.0.host
}
  }
  
