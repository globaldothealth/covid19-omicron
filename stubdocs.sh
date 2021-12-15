#!/bin/bash
# Generate stub README.md from BUILD files
# usage: ./stubdocs.sh [FOLDER]
#        if FOLDER is not specified look in current directory
#        for a BUILD file
FOLDER="${1:-.}"

list_sources() {
    echo "$sources" | while read -r url file; do
        echo -e "* $url\n  (saved at $file)"
    done
}

columns() {
    test -f "${name}.csv" || exit 0
    head -n 1 "${name}.csv" | tr ',' '\n' | sed 's/^\(.*\)/* **\1**:/g'
}

set -eou pipefail

cd $FOLDER
test -f BUILD || (echo ">>> ERROR: No BUILD file found" && exit 1)
unset name description output depends
source ./BUILD

cat << EOF
# $name

$description

## Sources

$(list_sources)

## Data dictionary

All column types are strings unless stated otherwise.

$(columns)

EOF
