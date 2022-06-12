#!/usr/bin/env python

import argparse
import functools
import subprocess


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--all-branches", action="store_true")
    parser.add_argument("--force", action="store_true")
    parser.add_argument("branches", nargs="*")
    return parser.parse_args()


class Git:
    def run(self, cmd, *args, capture_stdout=True):
        kwargs = {"check": True}
        if capture_stdout:
            kwargs["stdout"] = subprocess.PIPE
            kwargs["text"] = True
        r = subprocess.run(["git", cmd, *args], **kwargs)
        return r.stdout.strip() if capture_stdout else None

    def __getattr__(self, name):
        name = name.replace("_", "-")
        return functools.partial(self.run, name)


args = parse_args()

git = Git()

# Halt if there are uncommitted changes.
git.diff("--exit-code", capture_stdout=False)

current_branch = git.branch("--show-current")
git.checkout("--detach")
try:
    git.fetch("--all", "--prune")

    if args.all_branches:
        upstream_branches = git.for_each_ref(
            "--format=%(refname:lstrip=3)", "refs/remotes/upstream/"
        ).split()
    elif args.branches:
        upstream_branches = args.branches
    else:
        upstream_branches = [current_branch]

    fetch_refspec = [f"{branch}:{branch}" for branch in upstream_branches]
    git.fetch("upstream", "--no-tags", *fetch_refspec)

    options = ["--set-upstream", "--tags"]
    if args.force:
        options.append("--force-with-lease")
    git.push(*options, "origin", *upstream_branches)
finally:
    if current_branch:
        git.checkout(current_branch)
