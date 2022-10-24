#! /bin/bash
echo "*** Updating fzf"
echo "[ ] Checking remote and local tags"
remote_tag=$(curl -sL https://api.github.com/repos/junegunn/fzf/releases/latest | jq -r ".tag_name")

local_tag=$(fzf --version | awk '{print $1}')

echo "*** Remote: " $remote_tag
echo "*** Local:  " $local_tag

if [ "$remote_tag" = "$local_tag" ]; then
    echo ""
    echo "*** No new version. Exiting."
else
    echo "*** Updating..."
    cd ~/.fzf
    git fetch && git pull
    bash install
    echo ""
    echo "*** fzf updated ***"
fi