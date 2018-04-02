.PHONY: all
all: /usr/bin/ansible-playbook
	$< --verbose system.yml


/usr/bin/ansible-playbook:
	sudo dnf -y install ansible
