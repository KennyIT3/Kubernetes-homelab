# RHEL + Kubernetes Homelab Platform

## Overview

This project is a Proxmox-based Linux and Kubernetes homelab built to practice real-world systems administration, Ansible automation, Kubernetes platform engineering, infrastructure provisioning, and production-style troubleshooting.

The lab has two main tracks:

1. **RHEL Enterprise Linux Automation Track**
   - RHEL 8 and RHEL 9 managed with Ansible
   - Baseline system configuration
   - User and sudo management
   - firewalld automation
   - Podman, Buildah, and Skopeo tooling
   - Kubernetes prerequisite setup
   - Enterprise Linux troubleshooting practice

2. **Ubuntu K3s Kubernetes Platform Track**
   - Ubuntu 24.04 VMs provisioned on Proxmox with Terraform
   - K3s Kubernetes cluster
   - Ansible-driven node preparation
   - Future GitOps with FluxCD
   - Future ingress, monitoring, storage, backup, and application deployment labs

The goal is to build a job-ready homelab that reflects both enterprise Linux operations and modern Kubernetes platform engineering.

---

## Lab Architecture

| System | OS | Role |
|---|---|---|
| ansible-ctrl | Ubuntu Server 24.04 | Ansible, Terraform, kubectl, Git control node |
| rhel8 | Red Hat Enterprise Linux 8 | RHEL managed node / Kubernetes prep lab |
| rhel9 | Red Hat Enterprise Linux 9 | RHEL managed node / Kubernetes prep lab |
| k8s-cp-01 | Ubuntu Server 24.04 | K3s control plane |
| k8s-wk-01 | Ubuntu Server 24.04 | K3s worker node |
| k8s-wk-02 | Ubuntu Server 24.04 | K3s worker node |
| ai01 | Ubuntu Server 24.04 | Separate AI/automation project VM |

The virtual machines are hosted on Proxmox and use local LVM-thin storage for VM disks.

Terraform provisions the Ubuntu Kubernetes VMs through the Proxmox API. Ansible configures Linux hosts and prepares them for Kubernetes. Kubernetes workloads will later be managed through GitOps.

---

## Operating Model

```text
ansible-ctrl
├── Terraform/OpenTofu  -> provisions Proxmox VMs
├── Ansible             -> configures Linux and Kubernetes prerequisites
├── kubectl             -> manages Kubernetes
├── Git/GitHub          -> tracks infrastructure automation
└── FluxCD              -> future GitOps controller

Proxmox
├── rhel8
├── rhel9
├── k8s-cp-01
├── k8s-wk-01
├── k8s-wk-02
└── ai01
