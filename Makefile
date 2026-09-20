.PHONY: all
all: /usr/bin/ansible-playbook
	$< --verbose playbook.yaml

/usr/bin/ansible-playbook:
	sudo dnf -y install ansible

node_modules: package.json
	npm install

.PHONY: format
format: node_modules
	npx --no -- prettier --write .

.PHONY: lint
lint:
	ansible-lint

SHELL_FILES := $(shell find -name \*.sh -print)
SHELL_FILES += \
	bootstrap

PHONY_TARET: shellcheck
shellcheck:
	shellcheck --enable all $(SHELL_FILES)
