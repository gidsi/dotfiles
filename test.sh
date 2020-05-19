#!/usr/bin/env bash

set -e
set -x

for role in $(ls roles)
do
        cd roles/$role
        if [[ -d ./molecule ]]; then
            molecule test
        fi
  cd ../..
done
