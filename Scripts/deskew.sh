#!/bin/bash
inputPDF="$1"
tempPDF=temp
dpi=325 #set dpi
fmt="pgm"

#create temp
currentDir="$(pwd)"
tempDir="$(mktemp -d --tmpdir=$currentDir)"

#output file name
pages="$(pdfinfo "$inputPDF" | grep Pages: | awk '{print $2}')"
echo "Deskewing $inputPDF, $pages pages"

#convert to pgm
pdftoppm -gray -r "$dpi" "$inputPDF" "$tempDir/$tempPDF"

for i in "$tempDir"/temp-*."$fmt"; do
    iPDF="${i%.$fmt}.pdf"
    echo "Converting $(basename $tempDir)/$(basename $i) to $(basename $iPDF)"
    #remove border (if black), deskew and remove border
    convert -density "$dpi" -fuzz 10% -fill white -draw 'color 0,200 floodfill' \
        -deskew 80% -background white \
        +repage -fuzz 20% -trim +repage "$i" "$iPDF"
    rm "$i"
done

#rename file
mv "$inputPDF" "${inputPDF%.pdf}_skew.pdf"

#to ghostscript, prepress - compress dpi > 300 -dPDFSETTINGS=/prepress
echo "Combining files to $inputPDF, setting title to ${inputPDF%.pdf}"
gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -r300 -sOutputFile="$inputPDF" "$tempDir"/temp-*.pdf
exiftool -Title="${inputPDF%.pdf}" -overwrite_original_in_place "$inputPDF"

#delete temp files
echo "Deleting temp files"
rm -rf "$tempDir"
