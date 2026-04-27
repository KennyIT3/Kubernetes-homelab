#!/usr/bin/env bash

LAB_VMS=(200 201 202)
pv() {
  pvesm status | awk '
  NR==1 {
    printf "%-15s %-8s %-8s %10s %10s %10s %8s\n", $1,$2,$3,"Total","Used","Avail",$7
    next
  }
  {
    total=$4/1024/1024
    used=$5/1024/1024
    avail=$6/1024/1024
    printf "%-15s %-8s %-8s %10.2fG %10.2fG %10.2fG %8s\n", $1,$2,$3,total,used,avail,$7
  }'
}


lss() {
  qm list | awk 'NR==1 || $1 ~ /^(200|201|202)$/'
  echo
  pv
}

startlab() {
  echo "[INFO] Starting RHEL Ansible lab VMs..."
  for vmid in "${LAB_VMS[@]}"; do
    qm start "$vmid" 2>/dev/null || echo "[WARN] VM $vmid may already be running"
  done
  labstatus
}

stoplab() {
  echo "[INFO] Shutting down RHEL Ansible lab VMs..."
  for vmid in 202 201 200; do
    qm shutdown "$vmid" 2>/dev/null || echo "[WARN] VM $vmid may already be stopped"
  done
}

snl() {
  local snap_name="${1:-manual-$(date +%Y%m%d-%H%M%S)}"

  echo "[INFO] Creating snapshot '$snap_name' for lab VMs..."
  for vmid in "${LAB_VMS[@]}"; do
    qm snapshot "$vmid" "$snap_name"
  done
}

lsl() {
  for vmid in "${LAB_VMS[@]}"; do
    echo
    echo "===== VM $vmid snapshots ====="
    qm listsnapshot "$vmid"
  done
}
