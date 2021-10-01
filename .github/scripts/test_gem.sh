#!/usr/bin/env bash
# shellcheck disable=3000-SC4000

set -o errexit # Abort if any command fails
me=$(basename "$0")

help_message="\
Usage:
  ${me} --workdir <workdir> [--verbose]
  ${me} --help
Arguments:
  -w, --workdir <workdir>       The path to the working directory.
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
        elif [[ $1 = "-w" || $1 = "--workdir" ]]; then
            workdir=${2// }

            if [[ "${workdir}" = "--"* ]]; then
                workdir=""
                shift 1
            else
                shift 2
            fi
        else
            break
        fi
    done

    if [[ -z "${workdir}" ]]; then
        echo "Missing required argument: --workdir <workdir>." >&2
        echo "${help_message}" >&2
        return 1
    fi
}

# Echo expanded commands as they are executed (for debugging)
enable_expanded_output() {
    if [ "${verbose}" = true ]; then
        set -o xtrace
        set +o verbose
        export VERBOSE=true
    fi
}

test_gem() {
    local jekyll_build_args=()

    cd "${workdir}"

    if [[ "${verbose}" = true ]]; then
        jekyll_build_args+=(--verbose)
    fi

    bundle install
    bundle exec jekyll build "${jekyll_build_args[@]}"

    file="${workdir}/_site/index.html"

    file_contains "${file}" "class=\"plantuml theme-swedbankpay\""
    file_contains "${file}" "<svg"
    file_contains "${file}" "<ellipse"
    file_contains "${file}" "<polygon"
    file_contains "${file}" "<path"
}

file_contains() {
    file=$1
    contents=$2

    if [[ -z "${file}" ]]; then
        echo "file_contains missing required argument <file>."
        return 1
    fi

    if [[ -z "${contents}" ]]; then
        echo "file_contains missing required argument <contents>."
        return 1
    fi

    if [[ ! -f "${file}" ]]; then
        echo "file_contains <file> not found: '${file}'."
        return 1
    fi

    if grep --quiet --fixed-strings "${contents}" "${file}"; then
        echo "Success! '${contents}' found in '${file}'."
    else
        echo "Failed! '${contents}' not found in '${file}'."

        if [ "${verbose}" = true ]; then
            cat "${file}"
        fi

        return 1
    fi
}

main() {
    parse_args "$@"
    enable_expanded_output
    test_gem
}

main "$@"
