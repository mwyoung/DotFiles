#!/bin/bash
displayID=$(xinput list --id-only 'Synaptics TM3053-003')
xinput set-prop $displayID "libinput Tapping Enabled" 1
xinput set-prop $displayID "libinput Accel Speed" .1
