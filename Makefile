.PHONY: all
all: /usr/bin/ansible-playbook
	ansible-playbook --verbose system.yml


/usr/bin/ansible-playbook:
	sudo dnf -y install ansible
