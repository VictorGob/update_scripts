#!/bin/bash
VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
echo "*** Docker-compose version found ${VERSION}"
LOCAL_V=$(docker-compose --version | awk '{print $4}')
echo "*** Docker-compose local version ${LOCAL_V}"

if [ "$VERSION" = "$LOCAL_V" ]; then
    echo ""
    echo "*** No new version. Exiting."
else
    echo "*** Updating..."
    sudo curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "*** Docker-compose updated ***"
fi