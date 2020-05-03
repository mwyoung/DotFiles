#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo 'Use h (html), m (mobi), or t (txt) for input, use in folder'
    exit 1
fi

ending="notFound"

if [[ "$1" == "t" ]]; then
    ending=".txt"
elif [[ "$1" == "h" ]]; then
    ending=".html"
elif [[ "$1" == "m" ]]; then
    ending=".mobi"
else
    echo -e "$1 not in list"
    exit 1
fi

for book in *"$ending"
do
	echo "Converting $book"
    #ebook-convert "$book" "$(basename "$book" $ending).mobi"
done
