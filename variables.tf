variable "resource_group_name" {default = "tangoe"}
variable "location" {
  default = "East US"
}

variable "address_space" {
  description = "value of the address space for the virtual network."
  type        = string
  default = "10.0.0.0/16"
}

variable "address_prefixes" {
  description = "value of the address prefixes for the virtual network."
  type        = list(string)
  default = [ "10.0.1.0/24" ] 
}

variable "nic_name" {
  description = "The name of the network interface to create."
  type        = string
  default     = "tangoe-nic"
  
}

variable "private_ip_address" {
  description = "value of the private IP address to assign to the virtual machine."
  type        = string
  default = "10.0.0.0"  
}

variable "public_ip_address_id" {
  description = "The ID of the public IP address to associate with the virtual machine."
  type        = string
  default     = null
}

variable "private_ip_address_allocation" {
  description = "The allocation method for the private IP address."
  type        = string
  default     = "Dynamic"
  
}

variable "vm" {
  type = object({
    name              = string
    size              = string
    image_publisher   = string
    image_offer       = string
    image_sku         = string
    admin_username    = string
    admin_password    = string
  })
  default = {
    name              = "tangoe-vm"
    size              = "Standard_B2as_v2"
    image_publisher   = "MicrosoftWindowsServer"
    image_offer       = "WindowsServer"
    image_sku         = "2019-Datacenter"
    admin_username    = "adminuser"
    admin_password    = "P@ssw0rd1234!"
  }
}

variable "data_disk_attachment" {
  type = object({
    disk_size_gb = number
  })
  default = {
    disk_size_gb = 128
  }
  
}




