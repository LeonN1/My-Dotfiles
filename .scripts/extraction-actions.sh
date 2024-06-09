#!/bin/sh

exec 2>/dev/null

extract_here() {
    for file in "$@"; do
        7z x "$file"
    done
}

extract_in_folder() {
    path="$1"
    temp="${path##*/}" 
    folder="${temp%.*}"

    for file in "$@"; do
        7z x "$file" -o"$folder"
    done
}

add_files() {
    path="$1"
    archive="${path##*/}" 

    7z a "$archive.7z" "$@"
}

case "$1" in
    "extract_here")
        shift
        extract_here "$@"
        ;;
    "extract_in_folder")
        shift
        extract_in_folder "$@"
        ;;
    "add_files")
        shift
        add_files "$@"
        ;;
    *)
        exit 1
        ;;
esac
