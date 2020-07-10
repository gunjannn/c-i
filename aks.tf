

provider "azurerm" {
  version = "=1.44.0"
  subscription_id = "64b70538-bc40-4492-9c4b-13f8b43e732d"
  client_id       = "9f165633-0fb1-46ed-9a89-acca8547244c"
  client_secret   = "I7Xd.2RbIWV1o6Ip9k.S-Q6JsQmD~QJVK_"
  tenant_id       = "2b6d0a61-dfad-4b8b-8763-0cb831697a57"

 
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

  /*identity {
    type = "SystemAssigned"
  }*/

  service_principal {
    client_id = "3df2bfee-ee00-4516-bebb-693639119968"
    client_secret = "1DnE_p3Mm1VTa7garwN7nynbDXXN1LCCLj"
  }
  tags = {
    Terraform = "True"
  }
}

output "env-dynamic-url" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.host
}
