#!/bin/bash
# For downloading webpages, also has option (passwordneeded) to save cookies
#Source: https://stackoverflow.com/questions/52269829/sharepoint-authentication-with-puppeteer-and-node-js/52576048#52576048
browser=google-chrome
data_dir=temp_dir
passwordneeded=1

if [[ "$#" -eq 2 ]]; then
    domain='$1'
    pages="$2"
elif [[ "$#" -eq 0 ]]; then
    #if url has & in it
    printf "Input URL: "
    read domain
    printf "Number of pages: "
    read pages
else
    echo "Arguments wrong"
    exit 1
fi

if [[ "$passwordneeded" -eq 1 ]]; then
    echo "Opening web browser, please input in the password to save cookies"
    eval $browser --user-data-dir="$data_dir" --password-store=basic
fi

echo "Downloading to `pwd`"

#get pages
for (( i = 1 ; i <= "$pages" ; i++ )); do
    echo "Downloading page $i for $domain$i"
	eval $browser --headless --disable-gpu --print-to-pdf="${i}.pdf" \
        --user-data-dir="$data_dir" \
        --virtual-time-budget=5000 '$domain$i'
    sleep 2     #be nice to the webhost :)
done

if [[ -f "$pages.pdf" ]]; then
    pdfunite $(ls -v *.pdf) output.pdf
    echo "pdfs combined"
else
    echo "no pdfs..."
fi

#remove old data/passwords
rm -rf "$data_dir"
