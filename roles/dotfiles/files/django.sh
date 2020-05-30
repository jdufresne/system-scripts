initdj() {
    initproj
    root=$(git rev-parse --show-toplevel)
    pip install \
        -r ${root}/tests/requirements/py3.txt \
        -r ${root}/tests/requirements/postgres.txt \
        -r ${root}/tests/requirements/mysql.txt \
        isort \
        sphinx \
        sphinxcontrib.spelling
}
