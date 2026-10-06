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

## Skills Demonstrated

### Implemented: Linux / RHEL Administration

- RHEL 8 and RHEL 9 system administration
- SSH key-based automation access
- Static Ansible inventory design
- RHEL subscription and repository enablement
- Baseline system configuration
- User, group, and sudoers management
- Safe sudoers validation with `visudo`
- firewalld automation
- Package management with `dnf`
- SELinux-aware troubleshooting
- systemd service management
- Kernel module and sysctl configuration
- Podman, Buildah, and Skopeo installation/testing

### Implemented: Ansible Automation

- Ansible roles and playbooks
- Group variables and host variables
- Idempotent task design
- Conditional logic with `when`
- Facts and `set_fact`
- Jinja2 templating
- Serial patching workflows
- Pre-checks and post-checks
- Conditional reboot handling
- Multi-OS inventory organization
- Separate RHEL and Ubuntu host groups

### Implemented: Infrastructure Provisioning

- Proxmox VM provisioning
- Terraform with the Proxmox provider
- Ubuntu cloud image based VM creation
- Separate Terraform state per project
- VM lifecycle management
- Git-based infrastructure workflow
- Git branch workflow for platform changes

### In Progress: Kubernetes / Platform Engineering

- Kubernetes node preparation
- K3s cluster design
- Control plane and worker node separation
- Ubuntu K3s node provisioning
- Kubernetes prerequisite automation
- Kernel module and bridge networking setup
- Ansible-driven node preparation

### Planned: Kubernetes Platform Features

- K3s control plane installation
- K3s worker node joins
- kubeconfig setup on `ansible-ctrl`
- Test application deployment
- Ingress configuration
- FluxCD GitOps workflows
- Monitoring with Prometheus and Grafana
- Persistent storage labs
- Backup and restore workflows
- RBAC and NetworkPolicy security labs

---
## Directory Structure

```
rhel-ansible-lab/
├── ansible.cfg
├── inventory/
│   ├── hosts.example.ini
│   └── hosts.ini
├── group_vars/
│   ├── all.yml
│   ├── rhel.yml
│   ├── rhel8_nodes.yml
│   └── rhel9_nodes.yml
├── host_vars/
│   ├── rhel8.yml
│   └── rhel9.yml
├── playbooks/
│   ├── 00-register-rhel.yml
│   ├── 00-validate.yml
│   ├── 01-baseline.yml
│   ├── 02-users-sudo.yml
│   ├── 03-patching.yml
│   ├── 04-firewall.yml
│   ├── 05-podman.yml
│   ├── 06-k8s-prereqs.yml
│   ├── rhel-k8s-lab.yml
│   ├── ubuntu-k3s-prereqs.yml
│   ├── baseline.yml
│   ├── users-sudo.yml
│   ├── firewall.yml
│   ├── containers.yml
│   ├── k8s-prereqs.yml
│   └── site.yml
├── roles/
│   ├── baseline/
│   ├── users_sudo/
│   ├── firewall/
│   ├── podman/
│   └── k8s_prereqs/
├── terraform/
│   └── proxmox/
│       └── k3s/
│           ├── main.tf
│           ├── variables.tf
│           ├── outputs.tf
│           ├── providers.tf
│           └── .gitignore
├── kubernetes/
│   ├── docs/
│   │   └── 01-kubeadm-cluster-build.md
│   ├── manifests/
│   └── scripts/
├── create-vms.sh
├── lab-functions.sh
├── setup_ansible.sh
└── README.md
```
