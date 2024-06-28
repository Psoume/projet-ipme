provider "vsphere" {
  user                 = "mgaspard@vsphere.local"
  password             = "Y?tePe^{8"
  vsphere_server       = "192.168.140.10"
  allow_unverified_ssl = true
}

resource "vsphere_file" "ubuntu_vmdk_upload" {
  datacenter         = "Datacenter"
  datastore          = "datastore2"
  source_file        = "kickstart.iso"
  destination_file   = "zebi/kickstart.iso"
  create_directories = true
}