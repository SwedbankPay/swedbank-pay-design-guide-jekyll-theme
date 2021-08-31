#!/usr/bin/env bash
set -o errexit # Abort if any command fails
me=$(basename "$0")

help_message="\
Usage:
  ${me} --version <version> [--verbose]
  ${me} --help
Arguments:
  -V, --version <version>       The version of the Gem to build.
  -h, --help                    Displays this help screen.
  -v, --verbose                 Increase verbosity. Useful for debugging."

parse_args() {
    while : ; do
        if [[ $1 = "-h" || $1 = "--help" ]]; then
            echo "${help_message}"
            return 0
        elif [[ $1 = "-v" || $1 = "--verbose" ]]; then
            verbose=true
            shift
        elif [[ $1 = "-V" || $1 = "--version" ]]; then
            version=${2// }

            if [[ "${version}" = "--"* ]]; then
                version=""
                shift 1
            else
                shift 2
            fi
        else
            break
        fi
    done

    if [[ -z "${version}" ]]; then
        echo "Missing required argument: --version <version>." >&2
        echo "${help_message}"
        return 1
    fi
}

# Echo expanded commands as they are executed (for debugging)
enable_expanded_output() {
    if [ "${verbose}" = true ]; then
        set -o xtrace
        set +o verbose
    fi
}

build_gem() {
    sed -i -e "s/0.0.1.dev/${version}/g" ./lib/gem_version.rb
    gem_build_name=$(gem build swedbank-pay-design-guide-jekyll-theme.gemspec | awk '/File/ {print $2}')
    [ "${verbose}" = true ] && echo "Gem filename: '${gem_build_name}'"
    echo "::set-output name=name::${gem_build_name}"
}

main() {
    parse_args "$@"
    enable_expanded_output
    build_gem
}

main "$@"
