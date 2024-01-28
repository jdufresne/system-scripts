.PHONY: all
all: /usr/bin/ansible-playbook
	$< --verbose system.yaml

/usr/bin/ansible-playbook:
	sudo dnf -y install ansible

SHELL_FILES = $(shell find -name \*.sh -print)

PHONY_TARET: shellcheck
shellcheck:
	shellcheck --enable all $(SHELL_FILES)
