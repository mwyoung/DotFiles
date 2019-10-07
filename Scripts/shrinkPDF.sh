#!/bin/bash

output=output.pdf

function shrinkPDF {
    echo "Shrinking $1"
    gs \
        -sOutputFile=$output \
        -sDEVICE=pdfwrite \
        -dPDFSETTINGS=/screen \
        -dCompatibilityLevel=1.4 \
        -dNOPAUSE \
        -dBATCH \
        "$1"

    #size: /screen (low), /ebook (mid), /printer (good), /prepress (best)

    if [ ! -f $output ]; then
        echo "No output file"
        return 1
    fi

    old=$(stat --printf="%s" "$1")
    new=$(stat --printf="%s" $output)

    if [ "$new" -lt "$old" ]; then
        echo "Saving old version"
        rename 's/\.pdf$/_old.pdf/' "$1"
        echo "Renaming shrunk version"
        mv $output "$1"
    else
        echo "Old is larger, removing new"
    #    rm $output
    fi
}

function bwPDF {
    echo "Getting BW version of $1"
    gs \
        -sOutputFile=$output \
        -sDEVICE=pdfwrite \
        -sColorConversionStrategy=Gray \
        -dProcessColorModel=/DeviceGray \
        -dCompatibilityLevel=1.4 \
        -dNOPAUSE \
        -dBATCH \
        "$1"

    echo "Saving color version"
    rename 's/\.pdf$/_c.pdf/' "$1"
    echo "Renaming BW version"
    mv $output "$1"
}

if [ $# -eq 0 ]; then
    echo "Shrinking all PDF files"
    for i in *.pdf; do
        shrinkPDF "$i"
    done
    exit 0
elif [ $# -eq 1 ]; then
    shrinkPDF "$1"
    exit 0
elif [[ $2 == b* ]]; then
    bwPDF "$1"
    exit 0
else
    echo "look at script..."
    exit 1
fi
