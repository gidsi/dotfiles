#!/usr/bin/env bash

set -e
set -x

python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

for role in $(ls roles)
do
        cd roles/$role
        if [[ -d ./molecule ]]; then
            python -m molecule test
        fi
  cd ../..
done
