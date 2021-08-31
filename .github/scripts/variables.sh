#!/bin/bash
set -o errexit #abort if any command fails
me=$(basename "$0")

help_message="\
Usage: echo $me <version>

Generates variables based on the provided environment variable GITHUB_CONTEXT
and <version> argument.

GITHUB_CONTEXT: An environment variable containing a JSON string of the GitHub
                context object. Typically generated with \${{ toJson(github) }}.
     <version>: The version number corresponding to the current Git commit."

initialize() {
    local github_context_json="$GITHUB_CONTEXT"
    version="$1"

    if [[ -z "$github_context_json" ]]; then
        echo "Missing or empty GITHUB_CONTEXT environment variable." >&2
        echo "$help_message"
        exit 1
    fi

    if [[ -z "$version" ]]; then
        echo "Missing required argument: <version>." >&2
        echo "$help_message"
        exit 1
    fi

    repository_url=$(echo "$github_context_json" | jq --raw-output '.event.repository.html_url | values')
    pr_repository_url=$(echo "$github_context_json" | jq --raw-output '.event.pull_request.head.repo.html_url | values')
    ref=$(echo "$github_context_json" | jq --raw-output '.ref | values')
    head_ref=$(echo "$github_context_json" | jq --raw-output '.head_ref | values')

    if [[ -n "$pr_repository_url" ]]; then
        # If $pr_repository_url is set (as it should be in pull requests), use that
        # as our $repository_url value instead of the main repository.
        repository_url="$pr_repository_url"
    fi

    if [[ -n "$head_ref" ]]; then
        # If $head_ref is set (as it should be in pull requests), use that
        # as our $ref value instead of the pull request ref.
        ref="$head_ref"
    fi

    if [[ -z "$repository_url" ]]; then
        echo "No 'event.repository.html_url' found in the GitHub context." >&2
        echo "$help_message"
        exit 1
    fi
}

generate_variables() {
    # Remove the 'refs/*/' prefix from $ref to get the bare branch name.
    branch="${ref#refs/tags/}"
    branch="${branch#refs/heads/}"

    if [[ "$ref" == refs/tags/* ]]; then
        # If a tag ref is being built, just use the tag verbatim
        version="${ref#refs/tags/}"
    else
        # Replace '+'' in the version number with '.'.
        version="${version//+/.}"
        # Replace '-' in the version number with '.'.
        version="${version//-/.}"
    fi


    echo "Branch:     $branch"
    echo "Version:    $version"
    echo "Repository: $repository_url"
    echo "::set-output name=branch::$branch"
    echo "::set-output name=version::$version"
    echo "::set-output name=repository_url::$repository_url"
}

main() {
    initialize "$@"
    generate_variables
}

main "$@"
