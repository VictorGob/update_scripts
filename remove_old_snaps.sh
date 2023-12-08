#!/bin/bash
# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS

set -eu

if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

sudo snap list --all | awk '/desactivado/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done
echo "*** END ***"

