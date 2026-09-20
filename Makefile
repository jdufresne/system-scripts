.PHONY: all
all: /usr/bin/ansible-playbook
	$< --verbose playbook.yaml

/usr/bin/ansible-playbook:
	sudo dnf -y install ansible

SHELL_FILES := $(shell find -name \*.sh -print)
SHELL_FILES += \
	bootstrap

PHONY_TARET: shellcheck
shellcheck:
	shellcheck --enable all $(SHELL_FILES)
