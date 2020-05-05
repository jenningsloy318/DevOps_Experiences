

variable "openstack_image_name" {
    description = "The image name."
}


variable "openstack_flavor" {
    description = "The instance flavor name."
    default = "m1.large"
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
    default = "SAP Global Cloud Service Center_private"
}

variable openstack_instance_count {
    description = "The instance count."
    default = 1
}
variable "openstack_instance_name" {
    description = "The instance name."
}



variable "openstack_availability_zone_name" {
    description = "The  availability zone install will be created in."
}
