resource "azurerm_firewall" "demofw" {
  name                = var.firewallname
  location            = azurerm_resource_group.demofwrg.location
  resource_group_name = azurerm_resource_group.demofwrg.name
  firewall_policy_id  = azurerm_firewall_policy.demofwpolicy.id

  ip_configuration {
    name                 = "fwconfiguration"
    subnet_id            = azurerm_subnet.demofwsubnet[0].id
    public_ip_address_id = azurerm_public_ip.demofwpip.id
  }
}

resource "azurerm_firewall_policy" "demofwpolicy" {
  name                = var.fwpolicy
  location            = azurerm_resource_group.demofwrg.location
  resource_group_name = azurerm_resource_group.demofwrg.name
}

resource "azurerm_firewall_policy_rule_collection_group" "demofwpolicycollection" {
  name               = var.fwpolicycollection
  firewall_policy_id = azurerm_firewall_policy.demofwpolicy.id
  priority           = 500
  application_rule_collection {
    name     = "app_rule_collection1"
    priority = 500
    action   = "Deny"
    rule {
      name = "app_rule_collection1_rule1"
      protocols {
        type = "Http"
        port = 80
      }
      protocols {
        type = "Https"
        port = 443
      }
      source_addresses  = var.segments[0]
      destination_fqdns = var.destination_fqdns
    }
  }

  network_rule_collection {
    name     = "network_rule_collection1"
    priority = 400
    action   = "Deny"
    rule {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["TCP", "UDP"]
      source_addresses      = var.segments[0]
      destination_addresses = ["192.168.1.1", "192.168.1.2"]
      destination_ports     = ["80", "1000-2000"]
    }
  }

  /*nat_rule_collection {
    name     = "nat_rule_collection1"
    priority = 300
    action   = "Dnat"
    rule {
      name                = "nat_rule_collection1_rule1"
      protocols           = ["TCP", "UDP"]
      source_addresses    = var.sources
      destination_address = "192.168.1.1"
      destination_ports   = ["80"]
      translated_address  = "172.16.241.10"
      translated_port     = "8080"
    }
  }*/
}