# RHEL Ansible Automation Lab

## Overview

This project is a Proxmox-based RHEL automation lab built to practice Linux systems administration, Ansible automation, patching workflows, container tooling, and Kubernetes node preparation.

The lab uses an Ubuntu Ansible control node to manage RHEL 8 and RHEL 9 servers. The goal is to simulate common enterprise Linux automation tasks such as baseline configuration, user and sudo management, patching, firewalld configuration, Podman/Buildah/Skopeo installation, and Kubernetes prerequisite setup.

## Lab Architecture

| System | OS | Role |
|---|---|---|
| ansible-ctrl | Ubuntu Server 24.04 | Ansible control node |
| rhel8 | Red Hat Enterprise Linux 8 | Managed node / container host / Kubernetes worker prep |
| rhel9 | Red Hat Enterprise Linux 9 | Managed node / Kubernetes control-plane prep |

The virtual machines are hosted on Proxmox and use local LVM-thin storage for VM disks. VM lifecycle tasks such as starting, stopping, snapshotting, and checking VM IPs are managed from the Proxmox host. OS configuration and automation are handled by Ansible from the control node.

## Skills Demonstrated

- Proxmox VM provisioning and lifecycle management
- Linux system administration on RHEL 8 and RHEL 9
- SSH key-based automation access
- Static Ansible inventory design
- Ansible roles, playbooks, group variables, and host variables
- Python interpreter handling for RHEL systems
- RHEL subscription and repository enablement
- Idempotent baseline configuration
- User, group, and sudoers management
- Safe sudoers validation with `visudo`
- Serial patching with pre-checks and post-checks
- Conditional reboot handling
- firewalld automation
- Podman, Buildah, and Skopeo installation/testing
- Kubernetes prerequisite automation
- Jinja2 templating
- `set_fact` and `when` conditionals
- Git-based infrastructure automation workflow

## Directory Structure

```text
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
└── README.md
