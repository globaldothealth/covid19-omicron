#!/bin/bash

set -eou pipefail

do_build=1
do_fetch=0
do_hash=0
do_checkhash=0
do_tests=0
folder="."

abort() {
    test -v name && echo ">>> $name: ERROR: $*" && exit 1
    echo ">>> ERROR: $*"
    exit 1
}

msg() {
    test -v name && echo ">>> $name: $*" && return
    echo ">>> $*"
}

setup() {
    :
}

tests() {
    :
}

fetch() {
    msg Fetching sources ...
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
    test -z "$sources" && return 0 # no sources
    source_files_missing=0
    for source_file in $source_files; do
        test -f $source_file || source_files_missing=1
    done
    test $source_files_missing -eq 1 && msg "Source files are missing" && fetch && do_fetch=0
    return 0
}

update_timestamp() {
    if [ -f last_updated_temp.txt ]; then
        rm last_updated_temp.txt
    fi
    for i in $output; do
        test -f "$i" || abort "Output file $i not found"
        echo -e "$(date -ur "$i" -Iseconds)\t$i" >> last_updated_temp.txt
    done
    mv last_updated_temp.txt last_updated.txt
}

update_hashes() {
    msg Saving source hashes ...
    source_files=$(echo "$sources" | awk '{print $2}' | tr '\n' ' ')
    # sha256sum for Linux, shasum on macOS
    if (command -v sha256sum > /dev/null); then
        sha256sum $source_files > sha256sums.txt
    elif (command -v shasum > /dev/null); then
        shasum -a 256 $source_files > sha256sums.txt
    else
        abort "sha256sum not present, required for hashes"
    fi
}

check_hashes() {
    if [ -z "$1" ]; then
        echo "check_hashes: specify filename to check against"
    fi
    if (command -v sha256sum > /dev/null); then
        sha256sum -c "$1"
    elif (command -v shasum > /dev/null); then
        shasum -a 256 -c "$1"
    else
        echo Warning: skipping hash checks as no suitable command found
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
  -c        check source hashes
  -t        run unit tests and exit
  -f FOLDER run build from FOLDER
  -h        show this help
EOF
    exit 0
}

check_depends() {
    for dep in $depends; do
        command -v "$dep" > /dev/null || abort "Requires '$dep' which is not installed, or not in PATH"
    done
}


while getopts tcmuUhf: options; do
        case $options in
            u) do_fetch=1;;
            U) do_fetch=1;do_build=0;;
            f) folder=$OPTARG;;
            m) do_hash=1;;
            c) do_checkhash=1;;
            t) do_tests=1;;
            h) usage;;
            *) usage; exit 1
        esac
done

pushd "$folder" > /dev/null
test $do_checkhash -eq 1 && check_hashes sha256sums.txt && popd && exit 0

test -f BUILD || abort "BUILD file not found"
unset name depends description output sources

source ./BUILD
test $do_tests -eq 1 && tests && exit 0
depends=${depends:-}
check_depends
output=${output:-${name}.csv}
require_sources
setup
test $do_fetch -eq 1 && fetch
test $do_hash  -eq 1 && update_hashes
test $do_build -eq 1 && msg Building ... && build
update_timestamp
msg "Successfully built: $output"
popd > /dev/null
