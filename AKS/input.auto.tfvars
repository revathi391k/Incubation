aks_vnet_name = "aksvnet"

sshkvsecret = "akssshpubkey"

clientidkvsecret = "spn-id"

spnkvsecret = "spn-secret"

vnetcidr = ["10.0.0.0/24"]

subnetcidr = ["10.0.0.0/25"]

keyvault_rg = "rk649253"

keyvault_name = "rk-inc-akv"

azure_region = "westus"

resource_group = "rk649253"

cluster_name = "aksdemocluster"

dns_name = "aksdemocluster"

admin_username = "aksuser"

kubernetes_version = "1.29.2"

agent_pools = {
      name            = "pool1"
      count           = 2
      vm_size         = "Standard_D2_v2"
      os_disk_size_gb = "30"
    }