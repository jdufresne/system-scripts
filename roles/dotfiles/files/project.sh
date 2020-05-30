initproj() {
    if [[ ! -v PYTHON ]]; then
        PYTHON=python3.9
    fi

    root=$(git rev-parse --show-toplevel)
    proj=$(basename ${root})
    rm -rf ~/.virtualenvs/${proj}
    ${PYTHON} -m venv ~/.virtualenvs/${proj}
    . ~/.virtualenvs/${proj}/bin/activate
}

workon() {
    root=$(git rev-parse --show-toplevel)
    proj=$(basename ${root})
    . ~/.virtualenvs/${proj}/bin/activate
}
