#!/bin/bash

initproj() {
    if [[ ! -v PYTHON ]]; then
        PYTHON=python3.9
    fi

    root=$(git rev-parse --show-toplevel)
    proj=$(basename "${root}")
    rm -rf "${HOME}/.virtualenvs/${proj}"
    ${PYTHON} -m venv "${HOME}/.virtualenvs/${proj}"
    . "${HOME}/.virtualenvs/${proj}/bin/activate"
}

workon() {
    root=$(git rev-parse --show-toplevel)
    proj=$(basename "${root}")
    . "${HOME}/.virtualenvs/${proj}/bin/activate"
}
