provider "azurerm" {
  version =  "~> 2.18"
  
client_id = "var.AZURE_CLIENT_ID"
client_secret = "var.AZURE_CLIENT_SECRET"
tenant_id = "var.AZURE_TENANT_ID"
subscription_id = "var.AZURE_SUBSCRIPTION_ID"


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
  
  /*output "env-dynamic-url" {
     value = azurerm_kubernetes_cluster.aks.kube_config.0.host
}*/
  }
  
