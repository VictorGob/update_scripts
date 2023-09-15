#! /bin/bash

echo "*** Updating bat"
echo "[ ] Checking remote and local tags"
remote_tag=$(curl -sL https://api.github.com/repos/sharkdp/bat/releases/latest | jq -r ".tag_name" | cut -c 2-)

local_tag=$(bat --version | awk '{print $2}')

echo "*** Remote: " $remote_tag
echo "*** Local:  " $local_tag

if [ "$remote_tag" = "$local_tag" ]; then
    echo ""
    echo "*** No new version. Exiting."
else
    echo "*** Updating..."
    remote_deb_call="curl -sL https://api.github.com/repos/sharkdp/bat/releases/latest | jq -r '.assets[] | select(.name==\"bat_${remote_tag}_amd64.deb\") | .browser_download_url'"
    remote_deb=$(eval "$remote_deb_call")
    echo "*** Remote URL deb: ${remote_deb}"
    wget ${remote_deb}
    echo "*** Installing package."
    sudo dpkg -i "bat_${remote_tag}_amd64.deb"
    echo ""
    echo "*** bat updated ***"
fi