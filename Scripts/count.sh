#!/bin/bash
count=0
loops=0

#find number of applications
function findApps {
    #pipe output to var, exclude cover letters, profile, application, interview
    findval=$(find "$i" -type f -name "*.pdf" \
        -not -iname "*[cC]over*" -not -iname "*[aA]pplication*" \
        -not -iname "*[pP]rofile*" -not -iname "*[iI]nterview*")
    #get a line count of pdfs
    result=$(echo "$findval" | wc -l | xargs)
}

#do each folder in 20xx, where xx is the year number (ex 2019)
for i in 20[0-9][0-9]/; do
    #run function
    findApps
    #check if a is not on command line
    if [[ "$1" == a* ]]; then
        #if yes, print out *all* files, for debugging
        echo "$findval" | sort
    fi
    printf "Folder: $i, Applications: $result\n" #print folder and num apps
    count=$((count + result))           #get overall result
    let "loops++"
done

if [ $loops -gt 1 ]; then
    printf "Total: $count\n" #print if 2+ folders
fi
