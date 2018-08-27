

variable "openstack_image_name" {
    description = "The image name."
    default  = ""
}


variable "openstack_flavor" {
    description = "The instance flavor name."
    default = ""
}



variable "openstack_keypair" {
    description = "The keypair name."
    default = ""
}


variable "openstack_secgroup_name" {
    description = "The security group name."
    default = ""
}


variable "openstack_tenant_network_name" {
    description = "The tenant network name."
    default = ""
}

variable "openstack_flp_network_name" {
    description = "The  Floating network name."
    default = ""
}
variable "openstack_flp_subnetwork_name" {
    description = "The  Floating subnetwork name."
    default = ""
}


variable "openstack_instance_name" {
    description = "The instance name."
    default = ""
}


variable "openstack_volume_size" {
    description = "The volume size."
    default = ""
}

variable "userdata" {
    description = "cloudinit userdata for instance ."
    default = ""
}
