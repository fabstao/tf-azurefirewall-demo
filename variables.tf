# Landing Zone variables

variable "resgroup" {
  type    = string
  default = "demofirewallrg"
}

variable "lzlocation" {
  type    = string
  default = "eastus"
}

variable "firewallname" {
  type    = string
  default = "demofirewall"
}

variable "vnets" {
  type    = list(string)
  default = ["dmfwvnet1"]
}

variable "subnetnames" {
  type    = list(string)
  default = ["AzureFirewallSubnet", "dmfwsubnet1"]
}

variable "subnets" {
  type    = list(list(string))
  default = [["172.16.241.0/26"], ["172.16.241.64/26"]]
}

variable "segments" {
  type    = list(list(string))
  default = [["172.16.240.0/22"]]
}

variable "sources" {
  type    = list(string)
  default = ["10.0.0.0/8", "172.0.0.0/8", "192.168.0.0/16"]
}

variable "fwpip" {
  type    = string
  default = "demofwpip"
}

variable "fwpolicy" {
  type    = string
  default = "demofwpolicy"
}

variable "fwpolicycollection" {
  type    = string
  default = "demofwpolicycollection"
}

variable "destination_fqdns" {
  type    = list(string)
  default = ["microsoft.com"]
}