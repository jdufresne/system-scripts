.PHONY: all
all: /usr/bin/ansible-playbook
	$< --verbose system.yaml

/usr/bin/ansible-playbook:
	sudo dnf -y install ansible

SHELL_FILES := $(shell find -name \*.sh -print)
SHELL_FILES += \
	bootstrap \
	roles/system/files/scripts/djt \
	roles/system/files/scripts/djtmy \
	roles/system/files/scripts/djtpg

PHONY_TARET: shellcheck
shellcheck:
	shellcheck --enable all $(SHELL_FILES)
