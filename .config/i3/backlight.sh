#!/bin/bash
#prevent duplicate script
#https://www.unix.com/302415844-post6.html
#exclude $$ (PID of self), basename $0 = this script
if pidof -x -o $$ $(basename "$0") >/dev/null ; then
    echo "Already running, exiting"
    exit
fi

curbrightness=$( echo "scale=0; $( xbacklight -get )/1" | bc )

if [[ $# -ne 2 ]]; then
    echo "bad number args, i # to inc, d # to dec"
    exit 1
fi

echo $curbrightness
if [[ "$1" == i* ]]; then
     if [[ "$2" -eq 1 ]]; then
         xbacklight -inc 1
    elif [[ "$2" -eq 5 ]]; then
         xbacklight -inc 5
    else
        echo "not increasing"
    fi
elif [[ "$1" == d* ]]; then
    if [[ "$2" -eq 1 ]]; then
        if [[ $curbrightness -ge 1 ]]; then
            xbacklight -dec 1
        fi
    elif [[ "$2" -eq 5 ]]; then
        if [[ $curbrightness -le 6 ]]; then
            xbacklight -set 1
        else
            xbacklight -dec 5
        fi
    else
        echo "not decreasing"
    fi
else
    echo "bad arguments"
fi

#if [[ $curbrightness -le 0 ]]; then
#    xbacklight -set 1
#fi
