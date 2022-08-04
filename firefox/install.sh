#!/bin/sh

profiles=~/Library/Application\ Support/Firefox/Profiles
if ! [[ -d  $profiles ]]; then
  echo "[ERROR]Looks like firefox isn't installed"
  exit 1
fi

for dir in $(ls "$profiles"); do
  [[ "$dir" != *default* ]] && exit 1
  ln -snf "$(pwd)"/chrome "$profiles/$dir/chrome"
done

echo "[INFO] Successfully linked userChrome to all firefox profiles"
