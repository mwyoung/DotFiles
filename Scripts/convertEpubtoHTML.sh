#!/bin/bash
for book in *.html
do
	echo "Converting $book"
   	ebook-convert "$book" "$(basename "$book" .html).epub"
done
