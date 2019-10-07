#!/bin/bash
disp="eDP1"
DP2="--output DP2"
HDMI1="--output HDMI1"

function activateTouchscreen {
    touchscreenID=$(xinput list --id-only 'ELAN Touchscreen')
    xinput map-to-output $touchscreenID $disp
}

#force with xrandr --output $disp --mode 1920x<tab>
if [[ "$#" -ne 1 ]]; then
    echo "Wrong inputs"
    exit 1
elif [[ "$1" == b* ]]; then
    #For both displays
    xrandr $DP2 --preferred --auto --left-of $disp $HDMI1 --auto --left-of DP2
    activateTouchscreen
elif [[ "$1" == m* ]]; then
    #Mirror displays
    xrandr $DP2 --preferred --auto --same-as $disp $HDMI1 --auto --same-as DP2
    activateTouchscreen
elif [[ "$1" == d* ]]; then
    #displayport
    xrandr $HDMI1 --auto --right-of $disp
    activateTouchscreen
elif [[ "$1" == v* ]]; then
    #vga
    xrandr $DP2 --auto --right-of $disp
    activateTouchscreen
elif [[ "$1" == o* ]]; then
    #off
    xrandr $DP2 --off $HDMI1 --off
    activateTouchscreen
elif [[ "$1" == a* ]]; then
    #arandr
    arandr
else
   echo "Bad arguments"
fi

