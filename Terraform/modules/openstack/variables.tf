

variable "openstack_image_name" {
    description = "The image name."
}


variable "openstack_flavor" {
    description = "The instance flavor name."
}



variable "openstack_keypair" {
    description = "The keypair name."
    default = "jennings-default-key"
}

variable "openstack_secgroup_name" {
    description = "The security group name."
    default = "default"
}

variable "openstack_private_network_name" {
    description = "The private network name."
}

variable openstack_instance_count {
    description = "The instance count."
    default = 1
}

variable "openstack_instance_name" {
    description = "The instance name."
}

variable "openstack_availability_zone_name" {
    description = "The  availability zone resources will be created in."
}

variable "openstack_data_volume_size" {
    description = "The size of data volume tied to the instance"
    default = 100
}

variable "openstack_flp_network" {
    description = "Floating IP network"
}
