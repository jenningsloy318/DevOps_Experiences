variable "vsphere_server" {
    description = "The  vsphere server address."
    default  = " "
}

variable "vsphere_user" {
    description = "The username for vsphere."
    default  = " "
}
variable "vsphere_password" {
    description = "The password for vsphere."
    default  = " "
}


variable "vsphere_datacenter" {
    description = "The datacenter for vsphere."
    default  = " "
}


variable "vsphere_resource_pool" {
    description = "The resource pool for vsphere."
    default  = " "
}

variable "vsphere_network"  {
    description = "The network used for vm."
    default  = " "
}


variable "vsphere_datastore_os"{
    description = "The datastore  used for vm os disk."
    default  = " "
}


variable "vsphere_datastore_data" {
    description = "The datastore  used for vm data disk."
    default  = " "
}

variable "vsphere_folder" {
    description = "The folder vm reside in."
    default  = " "
}


variable "vm" {
    default  = " "
}


variable "vsphere_vm_template"{
  default          = " "
}
