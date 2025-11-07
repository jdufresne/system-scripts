#!/bin/bash -eux

REPOS_BASE="${HOME}/devel/repos/"
WORKTREES_BASE="${HOME}/devel/worktrees/"

function repo() {
    cd "${REPOS_BASE}/${1}"
}

function worktree() {
    cd "${WORKTREES_BASE}/${1}"
}

function git-workon() {
    if [[ "$#" -ne 1 ]]; then
        printf "Wrong number of arguments (given %d expected 1)\n" "${#}" 1>&2
        return 1
    fi

    branch="${1}"
    git_root=$(git rev-parse --show-toplevel)

    if [[ "${git_root}" =~ ^"${REPOS_BASE}" ]]; then
        repo_dir="${git_root}"
        worktree_dir="${WORKTREES_BASE}${repo_dir#"${REPOS_BASE}"}/${branch}"
    elif [[ "${git_root}" =~ ^"${HOME}/devel/worktrees/" ]]; then
        parent_dir=$(dirname "${git_root}")
        repo_dir="${REPOS_BASE}${parent_dir#"${WORKTREES_BASE}"}"
        worktree_dir="${parent_dir}/${branch}"
    else
        printf "Not in a project directory\n" 1>&2
        return 1
    fi

    if [[ ! -d "${worktree_dir}" ]]; then
        git worktree add -b "${branch}" "${worktree_dir}"
    fi

    cd "${worktree_dir}"
}

function git-workoff() {
    if [[ "$#" -ne 0 ]]; then
        printf "Wrong number of arguments (given %d expected 0)\n" "${#}" 1>&2
        exit 1
    fi

    git_root=$(git rev-parse --show-toplevel)

    if [[ "${git_root}" =~ ^"${HOME}/devel/worktrees/" ]]; then
        branch=$(basename "${git_root}")
        parent_dir=$(dirname "${git_root}")
        repo_dir="${REPOS_BASE}${parent_dir#"${WORKTREES_BASE}"}"
    else
        printf "Not in a worktree directory\n" 1>&2
        exit 1
    fi

    cd "${repo_dir}"

    git worktree remove "${branch}"
}
