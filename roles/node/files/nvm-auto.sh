#!/bin/bash

autoload_nvmrc() {
    if [[ -f .nvmrc ]]; then
        nvm use --silent
    fi
}
export PROMPT_COMMAND="autoload_nvmrc;${PROMPT_COMMAND}"
