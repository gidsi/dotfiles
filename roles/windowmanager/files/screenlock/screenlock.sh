#!/bin/bash
set -xe

PICTURE_PATH=~/.config/i3/screenlock/pictures

RESOLUTION=$(xrandr -q | awk -F'current' -F',' 'NR==1 {gsub("( |current)","");print $2}')

RES_MAX_X="${RESOLUTION%%x*}"
RES_MAX_Y="${RESOLUTION##*x}"

ASPECT_RATIO=$(echo "scale=2; $RES_MAX_X / $RES_MAX_Y" | bc)
WIDE_SCREEN_THRESHOLD=1.7

if (( $(echo "$ASPECT_RATIO > $WIDE_SCREEN_THRESHOLD" | bc -l) )); then
    PICTURE_PATH="$PICTURE_PATH/wide"
else
    PICTURE_PATH="$PICTURE_PATH/normal"
fi
RANDOM_IMAGE=$(find ${PICTURE_PATH} | shuf -n 1)

screencapturelock() {
  cd /tmp || exit 1
  scrot lock.png
  convert lock.png -blur 5x5 lock.png
  composite ~/.dotfiles/roles/windowmanager/screenlock/chaospott.png lock.png lock.png
  #frosted -b 5 -s 5 lock.png lock.png
  i3lock -uef -i lock.png
  rm lock.png
}

resizepicturelock() {
  mkdir -p /tmp/screenlock
  cd /tmp/screenlock || exit 1
  convert "${RANDOM_IMAGE}" -resize "${RESOLUTION}^" -gravity Center -crop "${RESOLUTION}" +repage lock.png
  if [ -a lock-1.png ]; then
      mv lock-0.png lock.png
  fi
  i3lock -uef -i lock.png
  rm lock*.png
}

greenclip clear # clear clipboard
gpgconf --reload gpg-agent # forget gpg password

case "$1" in
  picture)
    resizepicturelock
    ;;
  *)
    i3lock -uef -i "$(find ${PICTURE_PATH} | shuf -n 1)"
esac

exit 0
