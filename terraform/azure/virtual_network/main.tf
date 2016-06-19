variable "location" {
  default = "West US"
}
variable "network_name" {
  defualt = "mantl"
}

variable "resource_name" {
  defualt = "production"
}

variable "subnet_name" {
  defualt = "mantl-subnet"
}

variable "address_space" {
  default = "10.1.0.0/21"
}
variable "subnet_cidr" {
  default = "10.1.1.0/24"
}
resource "azurerm_resource_group" "production" {
  name     = "${resource_name}"
  location = "${location}"

  tags {
    environment = "${resource_name}"
  }
}

resource "azurerm_virtual_network" "default" {
  name = "${network_name}"
  address_space = ["${address_space}"]
  location = "${location}"
  resource_group_name = "${azurerm_resource_group.production.name}"

  subnet {
    name = "${subnet_name}"
    address_prefix = "${subnet_cidr}"
  }
  tags {
    environment = "${resource_name}"
  }
}

output "resource_group_id" {
  value = "${azurerm_resource_group.production.id}"
}
output "virtual_network_id" {
  value = "${azurerm_virtual_network.default.id}"
}
