#!/bin/bash
#https://stackoverflow.com/a/16496491
usage() { echo "Usage: $0 [-b 0-20] [-o outputfile] [-d 72-600] [-r] [-p ppm,pgm,pbm] inputfile
    defaults: $0 -b 5% -d 300 -p pgm inputfile
    example: for i in *.pdf; do ./deskew \"\$i\"; done
    get image dpi size: pdfimages -list file.pdf" 1>&2; exit 1;}
#h = check w/o param, h: = check w/ param
while getopts "hb:d:o:r" arg; do
    case "${arg}" in
        b) b=${OPTARG} ;;
        d) d=${OPTARG} ;;
        o) p=${OPTARG} ;;
        p) p=${OPTARG} ;;
        r) r=1 ;;
        h) usage; exit 0 ;;
    esac
done
#remove optargs
shift $(($OPTIND-1))

inputPDF="$1"
if [[ ! -f "$inputPDF" ]]; then
    echo "File not found"
    exit 0
fi
tempPDF=temp
outputPDF="${inputPDF%.pdf}_skew.pdf"
border="5%"
if [[ ! -z "${b}" ]]; then
    border="${b}%"
fi
dpi=325 #set dpi
if [[ ! -z "${d}" ]]; then
    dpi="${d}"
fi
#https://en.wikipedia.org/wiki/Netpbm_format
fmt="pgm"
if [[ ! -z "${p}" ]]; then
    fmt="${p}"
fi

#create temp
currentDir="$(pwd)"
tempDir="$(mktemp -d --tmpdir=$currentDir)"

#output file name
pages="$(pdfinfo "$inputPDF" | grep Pages: | awk '{print $2}')"
echo "Deskewing $inputPDF, $pages pages with dpi $dpi"

#convert to pgm
pdftoppm -gray -r "$dpi" "$inputPDF" "$tempDir/$tempPDF"

for i in "$tempDir"/temp-*."$fmt"; do
    iPDF="${i%.$fmt}.pdf"
    echo "Converting $(basename $tempDir)/$(basename $i) to $(basename $iPDF)"
    #remove black border - if r exists
    if [[ ! -z "$r" ]]; then
        convert -density "$dpi" \
            -bordercolor black -border 1 \
            -fuzz 10% -fill white -draw 'color 0,0 floodfill' \
            "$i" "$i"
    fi
    #deskew, clean up image, trim blank part
    convert -density "$dpi" \
        -deskew 80% -background white \
        -lat 25x25-"$border" \
        +repage -fuzz 20% -trim +repage \
        "$i" "$i"

    #check return code if not successful
    if [ "$?" -ne 0 ]; then
        echo "Convert failed, exiting"
        rm -rf "$tempDir"
        exit 1
    fi

    #convert to pdf- binary img map to pdf
    pgSize="$(identify -format '%wx%h' $i)"
    img2pdf --title "${imputPDF%.pdf}" --imgsize "$dpi"dpi --output "$iPDF" "$i"
    #rm "$i"
done

#rename file
mv "$inputPDF" "$outputPDF"

#to ghostscript, prepress - compress dpi > 300 -dPDFSETTINGS=/prepress
echo "Combining files to $inputPDF, setting title to ${inputPDF%.pdf}"
gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -r"$dpi" \
    -sOutputFile="$inputPDF" "$tempDir"/temp-*.pdf
exiftool -Title="${inputPDF%.pdf}" -overwrite_original_in_place "$inputPDF"

#rename if setting
if [[ ! -z "${o}" ]]; then
    mv "$inputPDF" "${o}"
    mv "$outputPDF" "$inputPDF"
fi
#delete temp files
echo "Deleting temp files"
rm -rf "$tempDir"
