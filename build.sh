#!/bin/bash

set -eou pipefail

do_build=1
do_fetch=0
do_hash=0
folder="."

abort() {
    echo "$@"
    exit 1
}

setup() {
    :
}

fetch() {
    echo Fetching sources ...
    echo "$sources" | while read -r url file; do
        if [ -z "$file" ]; then
            echo "No file specified for $url"
            exit 1
        fi
        # silent (-s), show errors (-S), follow redirects (-L)
        curl -sS -L "$url" -o "$file"
    done
}

require_sources() {
    source_files=$(echo "$sources" | awk '{print $2}' | tr '\n' ' ')
    source_files_missing=0
    for source_file in $source_files; do
        test -f source_file || source_files_missing=1
    done
    test $source_files_missing -eq 1 && echo "Source files are missing" && fetch && do_fetch=0
}

update_timestamp() {
    if [ -f last_updated_temp.txt ]; then
        rm last_updated_temp.txt
    fi
    for i in $output; do
        echo -e "$(date -ur "$i" -Iseconds)\t$i" >> last_updated_temp.txt
    done
    mv last_updated_temp.txt last_updated.txt
}

update_hashes() {
    echo Saving source hashes ...
    source_files=$(echo "$sources" | awk '{print $2}' | tr '\n' ' ')
    if (command -v sha256sum > /dev/null); then
        sha256sum $source_files > sha256sums.txt
    else
        abort "sha256sum not present, required for hashes"
    fi
}


usage() {
    cat << EOF
build.sh: Build datasets

If no options are specified, build uses the existing source files
and re-runs the build stage. To update the sources and run the build
step at once, use 'build -u'

  -u        update sources (default is use sources already present)
  -U        update sources but do not run the build stage
  -m        save source hashes
  -f FOLDER run build from FOLDER
  -h        show this help
EOF
    exit 0
}

check_depends() {
    for dep in $depends; do
        command -v "$dep" || abort "Requires '$dep' which is not installed, or not in PATH"
    done
}


while getopts muUhf: options; do
        case $options in
            u) do_fetch=1;;
            U) do_fetch=1;do_build=0;;
            f) folder=$OPTARG;;
            m) do_hash=1;;
            h) usage;;
            *) usage; exit 1
        esac
done

pushd "$folder" || exit 1
test -f BUILD || abort "BUILD file not found"
unset name depends description output sources

source ./BUILD
depends=${depends:-}
check_depends
output=${output:-${name}.csv}
require_sources
setup
test $do_fetch -eq 1 && fetch
test $do_hash  -eq 1 && update_hashes
test $do_build -eq 1 && echo Building ... && build
update_timestamp
popd || exit 1
