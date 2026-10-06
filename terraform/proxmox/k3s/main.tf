#resource "proxmox_download_file" "ubuntu_2404_cloud_image" {
#  content_type = "import"
#  datastore_id = var.iso_datastore_id
#  node_name    = var.proxmox_node_name
#
#  url       = var.ubuntu_image_url
#  file_name = "noble-server-cloudimg-amd64.qcow2"
#}

resource "proxmox_virtual_environment_vm" "k3s_nodes" {
  for_each = var.k3s_nodes

  name      = each.key
  node_name = var.proxmox_node_name
  vm_id     = each.value.vm_id

  description = "K3s Kubernetes homelab node managed by Terraform"

  tags = [
    "terraform",
    "kubernetes",
    "k3s",
    "homelab"
  ]

  started = true
  on_boot = true

  cpu {
    cores = each.value.cores
    type  = "host"
  }

  memory {
    dedicated = each.value.memory_mb
  }

  agent {
    enabled = true
  }

  operating_system {
    type = "l26"
  }

  machine = "q35"

  scsi_hardware = "virtio-scsi-single"

  disk {
    datastore_id = var.datastore_id
    file_format  = "raw"
    interface    = "scsi0"
    size         = each.value.disk_gb
    import_from  = var.ubuntu_image_file_id
    discard = "on"
    ssd     = true
  }

  network_device {
    bridge = var.network_bridge
    model  = "virtio"
  }

  initialization {
    datastore_id = var.datastore_id

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      username = var.ssh_username
      keys     = [trimspace(file(pathexpand(var.ssh_public_key_path)))]
    }
  }
}
