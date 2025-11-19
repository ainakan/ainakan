#!/bin/bash

if [ -z "$AINAKAN_VERSION" ]; then
  echo "AINAKAN_VERSION must be set" > /dev/stderr
  exit 1
fi

set -e

cd build/release-assets
for name in *; do
  if echo $name | grep -q $AINAKAN_VERSION; then
    continue
  fi
  case $name in
    ainakan-*-devkit-*)
      new_name=$(echo $name | sed -e "s,devkit-,devkit-$AINAKAN_VERSION-,")
      ;;
    ainakan-server-*|ainakan-portal-*|ainakan-inject-*|ainakan-gadget-*|ainakan-swift-*|ainakan-clr-*|ainakan-qml-*|gum-graft-*)
      new_name=$(echo $name | sed -E -e "s,^(ainakan|gum)-([^-]+),\\1-\\2-$AINAKAN_VERSION,")
      ;;
    *)
      new_name=""
      ;;
  esac
  if [ -n "$new_name" ]; then
    mv -v $name $new_name
  fi
done
