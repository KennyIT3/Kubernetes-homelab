#!/usr/bin/env bash
set -euo pipefail

echo "== Ansible version =="
ansible --version | head -5

echo
echo "== Inventory graph =="
ansible-inventory --graph

echo
echo "== Syntax checks =="
for playbook in playbooks/*.yml; do
  echo "--- syntax: ${playbook}"
  ansible-playbook "${playbook}" --syntax-check
done

echo
echo "== ansible-lint =="
ansible-lint playbooks roles

echo
echo "== All Ansible checks passed =="
