variable "location" {
  default = "switzerland north"
}

variable "resourceGroupName" {
  default = "TestMyTerraformGroup"
}

variable "vnetFirstName" {
  default = "vNetTerraformA"
}

variable "vnetFirstAddressPrefix" {
  default = "10.230.0.0/16"
}

variable "vnetFirstSubnetDefaultName" {
  default = "Default"
}

variable "vnetFirstSubnetDefaultAddressPrefix" {
  default = "10.230.0.0/24"
}

variable "vnetSecondName" {
  default = "vNetTerraformB"
}

variable "vnetSecondAddressPrefix" {
  default = "10.231.0.0/16"
}
variable "vnetSecondSubnetDefaultName" {
  default = "Default"
}

variable "vnetSecondSubnetDefaultAddressPrefix" {
  default = "10.231.0.0/24"
}