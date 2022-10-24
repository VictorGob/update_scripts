#! /bin/bash
echo "*** Updating Starship"
echo "[ ] Checking remote and local tags"
remote_tag=$(curl -sL https://api.github.com/repos/starship/starship/releases/latest | jq -r ".tag_name")

local_tag=$(starship --version | head -n 1 | sed -e 's/starship /v/')

echo "*** Remote: " $remote_tag
echo "*** Local:  " $local_tag

if [ "$remote_tag" = "$local_tag" ]; then
    echo ""
    echo "*** No new version. Exiting."
else
    echo "*** Updating..."
    cargo install starship --locked
    echo ""
    echo "*** Startship updated ***"
fi