#!/bin/bash

RESOLUTION=$(xrandr -q | awk -F'current' -F',' 'NR==1 {gsub("( |current)","");print $2}')
RES_MAX=$(expr match ${RESOLUTION} '\(.[0-9]*\)')

PICTURE_PATH=~/.config/i3/screenlock/pictures
if [[ "$RES_MAX" -gt 1920 ]]; then
    PICTURE_PATH="$PICTURE_PATH/wide"
else
    PICTURE_PATH="$PICTURE_PATH/normal"
fi

RANDOM_IMAGE=${PICTURE_PATH}/$(find ${PICTURE_PATH} | shuf -n 1)

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
  convert "${RANDOM_IMAGE}" -resize "${RES_MAX}x${RES_MAX}" -gravity Center -crop "${RESOLUTION}" +repage lock.png
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
    i3lock -uef -i "${PICTURE_PATH}/$(find ${PICTURE_PATH} | shuf -n 1)"
esac

exit 0
