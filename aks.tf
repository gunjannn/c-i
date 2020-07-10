provider "azurerm" {
  /*version = "=1.44.0"*/

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

  service_principal {
    client_id         = "msi"
    client_secret     = "null"
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
