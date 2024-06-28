provider "vsphere" {
  user                 = var.user
  password             = var.password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "pclab" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore2" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.pclab.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.pclab.id
}

data "vsphere_resource_pool" "resources" {
  name          = "Resources"
  datacenter_id = data.vsphere_datacenter.pclab.id
}

resource "vsphere_virtual_machine" "terraform-test-projectgroup" {
  name             = var.name
  resource_pool_id = data.vsphere_resource_pool.resources.id
  datastore_id     = data.vsphere_datastore.datastore2.id
  num_cpus   = var.cpus
  memory     = var.memory
  guest_id   = "other3xLinux64Guest"
  
  network_interface {
    network_id   = data.vsphere_network.network.id
  }
  
  disk {
    label            = "disk0"
    size             = 20
    eagerly_scrub    = false
    thin_provisioned = true
  }

  cdrom {
    datastore_id = data.vsphere_datastore.datastore2.id
    path         = "ISO/AlmaLinux-8.10-x86_64-minimal.iso"
  }

  cdrom {
    datastore_id = data.vsphere_datastore.datastore2.id
    path         = file("${path.module}/kick.cfg")
  }

  scsi_type  = "lsilogic-sas"



}


