#!/usr/bin/env bash
set -euo pipefail

STORAGE="local-lvm"
ISO_STORAGE="local"
BRIDGE="vmbr0"

create_vm() {
  local vmid="$1"
  local name="$2"
  local cores="$3"
  local memory="$4"
  local disk="$5"
  local iso="$6"

  echo "[INFO] Creating VMID ${vmid}: ${name}"

  if qm status "$vmid" &>/dev/null; then
    echo "[SKIP] VMID ${vmid} already exists"
    return 0
  fi

  qm create "$vmid" \
    --name "$name" \
    --memory "$memory" \
    --cores "$cores" \
    --cpu host \
    --machine q35 \
    --scsihw virtio-scsi-single \
    --net0 virtio,bridge="$BRIDGE",firewall=1 \
    --agent enabled=1 \
    --ostype l26 \
    --onboot 0

  qm set "$vmid" \
    --scsi0 "${STORAGE}:${disk},discard=on,ssd=1" \
    --ide2 "${ISO_STORAGE}:iso/${iso},media=cdrom" \
    --boot order=scsi0\;ide2

  echo "[DONE] Created ${name}. Start it with: qm start ${vmid}"
}

create_vm 200 ansible-ctrl 2 4096 40 "ubuntu-24.04.4-live-server-amd64.iso"
create_vm 201 rhel9-lab    4 8192 80 "rhel-9.4-x86_64-dvd.iso"
create_vm 202 rhel8-lab    2 4096 60 "rhel-8.6-x86_64-dvd.iso"

echo "[COMPLETE] VM shells created. Install each OS from the Proxmox console."
