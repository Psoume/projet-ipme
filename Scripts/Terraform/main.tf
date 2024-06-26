
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

resource "null_resource" "admin_user_setup" {
  depends_on = [vsphere_virtual_machine.terraform-test-projectgroup]

  connection {
    type        = "ssh"
    host        = vsphere_virtual_machine.terraform-test-projectgroup.default_ip_address
    user        = "adminuser"
    private_key = file("./ssh_group")
  }

  provisioner "file" {
    source      = "ssh_group.pub"
    destination = "/tmp/ssh_group.pub"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p ~/.ssh",
      "cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys",
      "rm /tmp/id_rsa.pub"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo useradd -m adminuser",
      "sudo passwd adminuser <<EOF",
      "adminuser!",
      "adminuser!",
      "EOF"
    ]
  }
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

  scsi_type  = "lsilogic-sas"

  
#   extra_config = {
#     "guestinfo.userdata" = base64encode(data.template_file.cloud_init.rendered)
#     "guestinfo.userdata.encoding" = "base64"
#   }

}

data "template_file" "cloud_init" {
  template = file("./config_ip.yaml")
  vars = {
    hostname = var.hostname
    ip       = var.static_ip
    netmask  = var.subnet_mask
    gateway  = var.gateway
    domain   = var.domain
  }
}

