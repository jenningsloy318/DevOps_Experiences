

resource "vsphere_virtual_machine" "instance" {
  name             = "${var.vsphere_instance}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore_os.id}"

  num_cpus = "${var.vsphere_instance_cpu_count}"
  memory   = "${var.vsphere_instance_memory_count}"
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
        host_name = "${var.vsphere_instance}"
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



