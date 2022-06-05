.PHONY: all
all: /usr/bin/ansible-playbook
	$< --verbose system.yaml


/usr/bin/ansible-playbook:
	sudo dnf -y install ansible
