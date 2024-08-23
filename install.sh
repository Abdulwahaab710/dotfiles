#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  /bin/bash "$PWD/linux-install.sh"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  /bin/bash "$PWD/macos-install.sh"
fi
