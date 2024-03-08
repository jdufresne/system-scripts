#!/bin/bash -eux

function git-workon() {
    if [ "$#" -ne 1 ]; then
        printf "Wrong number of arguments (given %d expected 1)\n" "${#}" 1>&2
        return 1
    fi

    repos_base="${HOME}/devel/repos/"
    worktrees_base="${HOME}/devel/worktrees/"

    branch="${1}"
    if [[ $(pwd) =~ ^"${repos_base}".*\.git$ ]]; then
        git_root=$(pwd)
    else
        git_root=$(git rev-parse --show-toplevel)
    fi

    if [[ "${git_root}" =~ ^"${repos_base}" ]]; then
        repo_dir="${git_root}"
        worktree_dir="${worktrees_base}${repo_dir#"${repos_base}"}/${branch}"
    elif [[ "${git_root}" =~ ^"${HOME}/devel/worktrees/" ]]; then
        parent_dir=$(dirname "${git_root}")
        repo_dir="${repos_base}${parent_dir#"${worktrees_base}"}"
        worktree_dir="${parent_dir}/${branch}"
    else
        printf "Not in a project directory\n" 1>&2
        return 1
    fi

    if [[ ! -d "${worktree_dir}" ]]; then
        git worktree add "${worktree_dir}" "${branch}"
    fi

    cd "${worktree_dir}"
}

function git-workoff() {
    if [ "$#" -ne 0 ]; then
        printf "Wrong number of arguments (given %d expected 0)\n" "${#}" 1>&2
        exit 1
    fi

    git_root=$(git rev-parse --show-toplevel)

    repos_base="${HOME}/devel/repos/"
    worktrees_base="${HOME}/devel/worktrees/"

    if [[ "${git_root}" =~ ^"${HOME}/devel/worktrees/" ]]; then
        branch=$(basename "${git_root}")
        parent_dir=$(dirname "${git_root}")
        repo_dir="${repos_base}${parent_dir#"${worktrees_base}"}"
    else
        printf "Not in a worktree directory\n" 1>&2
        exit 1
    fi

    cd "${repo_dir}"

    git worktree remove "${branch}"
}
