#!/bin/bash
for book in *.epub
do
	echo "Converting $book"
   	ebook-convert "$book" "$(basename "$book" .epub).mobi"
done
