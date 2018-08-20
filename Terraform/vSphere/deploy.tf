data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_datastore" "datastore_os" {
  name          = "${var.vsphere_datastore_os}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


data "vsphere_datastore" "datastore_data" {
  name          = "${var.vsphere_datastore_data}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.vsphere_resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vsphere_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}




data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere_vm_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}



resource "vsphere_virtual_machine" "vm" {
  name             = "${var.vm}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore_os.id}"

  num_cpus = 2
  memory   = 1024
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
  }

  disk {
    label            = "os"
    unit_number      = 0
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    datastore_id     = "${data.vsphere_datastore.datastore_os.id}"
    }

  disk {
    label            = "data"
    unit_number      = 1
    size             = "60"
    datastore_id     = "${data.vsphere_datastore.datastore_data.id}"
    }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "${var.vm}"
        domain = "snfc.com"
      }

      network_interface {
        ipv4_address = "10.36.52.164"
        ipv4_netmask = "25"
      }

      ipv4_gateway = "10.36.52.129"
      dns_server_list =  ["114.114.114.114"]

    }
  }
}



output "VM IP address" {
value = "${vsphere_virtual_machine.vm.clone.0.customize.0.network_interface.0.ipv4_address}"
}
