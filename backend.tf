terraform {
  backend "azurerm" {
    storage_account_name = "lzdeploytfstatelatam"
    container_name       = "lzdpltfstatecontainer"
    key                  = "demofirewall.tfstate"
    resource_group_name  = "RGSandbox"
  }
}
