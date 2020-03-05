#!/bin/bash
usage() { echo "Usage: $0 -f (compile/hidden files) -d (show empty directories) -r (remove)
    example: $0 -f -r       removes compiled file names" 1>&2; exit 1;}
while getopts "hdfr" arg; do
    case "${arg}" in
        d) d=1 ;;
        f) f=1 ;;
        r) r=1 ;;
        h) usage; exit 0 ;;
    esac
done
shift $(($OPTIND-1)) #remove optargs

function delete_files {
    find . \( -name '._*' -or -name '*.sw[lmnop]' -or -name '*.bin' -or -name '*.hex' \
    -or -name '*.lst' -or -name '*.map' -or -name '*.srec' -or -name '*.raw' \) \
    -type f $1
}

if [[ -n "${f}" ]]; then
    delete_files "-print"
    if [[ -n "${r}" ]]; then
        echo "\tDeleting files"
        delete_files "-delete"
    fi
fi

function delete_empty_dir {
    find . -type d -not -path "*/.git/*" -empty "$1"
}

if [[ -n "${d}" ]]; then
    delete_empty_dir "-print"
    if [[ -n "${r}" ]]; then
        echo -e "\tDeleting empty directories"
        delete_empty_dir "-delete"
    fi
fi
