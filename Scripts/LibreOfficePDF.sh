#!/bin/bash

#get all odt files
for odtname in *.odt; do
	pdfname="$(basename "$odtname" .odt).pdf"
	#check if odt is newer than pdf
	if [ "$odtname" -nt "$pdfname" ]; then
		if  ! pgrep -x "soffice.bin" >/dev/null 2>&1  ; then
			echo "Converting $odtname"
			libreoffice --headless --convert-to pdf:writer_pdf_Export "$odtname"
		else
			echo "Libreoffice open"
		fi
	fi
done	

#merge pdfs
echo "Merging PDFs"
pdfunite *.pdf notes.pdf
