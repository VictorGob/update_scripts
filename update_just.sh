#! /bin/bash

echo "*** Updating just"
echo "[ ] Checking remote and local tags"
remote_tag=$(curl -sL https://api.github.com/repos/casey/just/releases/latest | jq -r ".tag_name")

local_tag=$(just --version | awk '{print $2}')

echo "*** Remote: " $remote_tag
echo "*** Local:  " $local_tag


if [ "$remote_tag" = "$local_tag" ]; then
    echo ""
    echo "*** No new version. Exiting."
else
    cd ~/.just/
    echo "*** Updating..."
    cargo install just
    echo "*** just updated ***"
fi