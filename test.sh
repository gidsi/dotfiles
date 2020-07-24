#!/usr/bin/env bash

set -e
set -x

docker build -t archlinux-python test/

for role in $(ls roles)
do
        cd roles/$role
        if [[ -d ./molecule ]]; then
            molecule test
        fi
  cd ../..
done
