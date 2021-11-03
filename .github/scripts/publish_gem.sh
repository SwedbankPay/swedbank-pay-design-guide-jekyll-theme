#!/usr/bin/env bash
set -o errexit # Abort if any command fails
me=$(basename "$0")

help_message="\
Publishes the theme as a Ruby gem to the GitHub Package Repository or RubyGems.

Usage:
  ${me} --gem <gem> --token <token> [--verbose]
  ${me} --gem <gem> --key <key> [--verbose]
  ${me} --help
Arguments:
  -t, --token <token>           The GitHub token to use.
  -k, --key <key>               The RubyGems API key to use.
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
        elif [[ $1 = "-g" || $1 = "--gem" ]]; then
            gem=${2// }

            if [[ "${gem}" = "--"* ]]; then
                gem=""
                shift 1
            else
                shift 2
            fi
        elif [[ $1 = "-t" || $1 = "--token" ]]; then
            token=${2// }

            if [[ "${token}" = "--"* ]]; then
                token=""
                shift 1
            else
                shift 2
            fi
        elif [[ $1 = "-k" || $1 = "--key" ]]; then
            key=${2// }

            if [[ "${key}" = "--"* ]]; then
                key=""
                shift 1
            else
                shift 2
            fi
        else
            break
        fi
    done

    if [[ -z "${gem}" ]]; then
        echo "Missing required argument 'gem'." >&2
        echo "${help_message}" >&2
        return 1
    fi

    if [[ -z "${token}" ]] && [[ -z "${key}" ]]; then
        echo "Missing required argument 'token' or 'key'." >&2
        echo "${help_message}" >&2
        return 1
    fi

    if [[ -n "${token}" ]] && [[ -n "${key}" ]]; then
        echo "The arguments 'token' and 'key' are mutually exclusive, both cannot be given at the same time." >&2
        echo "${help_message}" >&2
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

publish_gem() {
    credentials_file="$HOME/.gem/credentials"
    mkdir -p "$HOME/.gem"
    touch "${credentials_file}"
    chmod 0600 "${credentials_file}"

    if [[ -n "${token}" ]]; then
        printf -- "---\n:github: Bearer %s\n" "${token}" > "${credentials_file}"
        host="https://rubygems.pkg.github.com/SwedbankPay"
        set -e
        gem push --KEY github --host "${host}" "${gem}" \
            || echo "push failed ($?) probably due to the Gem '${gem}' already existing in GPR."
    else
        printf -- "---\n:rubygems_api_key: %s\n" "${key}" > "${credentials_file}"
        gem push "${gem}"
    fi
}

main() {
    parse_args "$@"
    enable_expanded_output
    publish_gem
}

main "$@"
