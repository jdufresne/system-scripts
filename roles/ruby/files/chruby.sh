auto-chruby() {
    lockfile=$(gemfile-default-lockfile)
    if [[ -n "${lockfile}" ]]; then
        chruby $(gemfile-ruby-version "${lockfile}")
    else
        chruby system
    fi
}

cd() {
    builtin cd "$@"
    auto-chruby
}

auto-chruby
