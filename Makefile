.PHONY: ansible-check syntax lint ping rhel-prep ubuntu-prep k3s-install

ansible-check:
	./scripts/ansible-check.sh

syntax:
	for playbook in playbooks/*.yml; do ansible-playbook $$playbook --syntax-check; done

lint:
	ansible-lint playbooks roles

ping:
	ansible all -m ping

rhel-prep:
	ansible-playbook playbooks/rhel-k8s-lab.yml

ubuntu-prep:
	ansible-playbook playbooks/ubuntu-k3s-prereqs.yml

k3s-install:
	ansible-playbook playbooks/07-install-k3s.yml
