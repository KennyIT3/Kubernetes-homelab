variable "proxmox_endpoint" {
  description = "Proxmox API endpoint"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API token in user@realm!tokenid=secret format"
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Skip TLS verification for Proxmox API"
  type        = bool
  default     = true
}

variable "proxmox_node_name" {
  description = "Proxmox node name"
  type        = string
  default     = "HomeServer"
}

variable "datastore_id" {
  description = "Proxmox datastore for VM disks"
  type        = string
  default     = "local-lvm"
}

variable "iso_datastore_id" {
  description = "Proxmox datastore for downloaded cloud image"
  type        = string
  default     = "local"
}

variable "network_bridge" {
  description = "Proxmox bridge used by VMs"
  type        = string
  default     = "vmbr0"
}

variable "ubuntu_image_url" {
  description = "Ubuntu 24.04 cloud image URL"
  type        = string
  default     = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

variable "ssh_username" {
  description = "Default VM SSH/cloud-init username"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key used for cloud-init"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
variable "ubuntu_image_file_id" {
  description = "Existing Ubuntu 24.04 cloud image file already present in Proxmox"
  type        = string
  default     = "local:import/noble-server-cloudimg-amd64.qcow2"
}

variable "k3s_nodes" {
  description = "K3s VM definitions"
  type = map(object({
    vm_id     = number
    cores     = number
    memory_mb = number
    disk_gb   = number
  }))

  default = {
    k8s-cp-01 = {
      vm_id     = 210
      cores     = 2
      memory_mb = 6144
      disk_gb   = 50
    }

    k8s-wk-01 = {
      vm_id     = 211
      cores     = 2
      memory_mb = 8192
      disk_gb   = 80
    }

    k8s-wk-02 = {
      vm_id     = 212
      cores     = 2
      memory_mb = 8192
      disk_gb   = 80
    }
  }
}
