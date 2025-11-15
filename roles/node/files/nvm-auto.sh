#!/bin/bash

autoload_nvmrc() {
    if [ "${PWD}" != "${_NVM_LAST_DIR}" ]; then
        if [ -f .nvmrc ]; then
            nvm use
        fi
        export _NVM_LAST_DIR="${PWD}"
    fi
}

export PROMPT_COMMAND="autoload_nvmrc;${PROMPT_COMMAND}"
