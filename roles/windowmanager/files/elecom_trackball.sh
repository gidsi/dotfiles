#!/bin/sh
POINTER="pointer:HID 056e:0132"
#POINTER="ELECOM TrackBall Mouse DEFT Pro TrackBall Mouse"

TRACKBALL_ID=$(xinput --list --id-only "$POINTER")
xinput set-prop "$TRACKBALL_ID" 'libinput Button Scrolling Button' 11
xinput set-prop "$TRACKBALL_ID" 'libinput Scroll Method Enabled' 0 0 1
xinput set-button-map "$TRACKBALL_ID" 1 10 3 4 5 6 7 8 2 2 11 12 13 14 15 16
