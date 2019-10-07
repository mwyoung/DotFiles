#!/bin/bash

if [ $# -eq 0 ]; then
	echo "No file"
    exit 1
elif [ ! -f "$1" ]; then
    echo "File not found"
    exit 1
elif [[ ! "$1" =~ \.pdf$ ]]; then
    echo "Not a pdf"
    exit 1
fi

outputFile=output.pdf
pdfcrop --margins 50 "$1" "$outputFile"
pdfnup --nup 2x1 --frame false "$outputFile"
rm "$outputFile"
