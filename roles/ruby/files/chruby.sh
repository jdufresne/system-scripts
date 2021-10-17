RUBY_VERSION_REGEXP="^ruby ([0-9]+\.[0-9]+\.[0-9]+)p[0-9]+$"

auto-chruby() {
    version=$(bundle platform --ruby 2> /dev/null)
    if [[ ${version} =~ ${RUBY_VERSION_REGEXP} ]]; then
        chruby "${BASH_REMATCH[1]}"
    else
        chruby system
    fi
}

cd() {
    builtin cd "$@"
    auto-chruby
}

auto-chruby
