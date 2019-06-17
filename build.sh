#!/bin/sh

latest=$(wget -q https://pypi.org/project/awscli/ -O -| egrep 'awscli \d+.\d+.\d+' | awk '{print $NF}')

echo $latest | egrep -q '^(\d+.\d+.\d+)$'
if [ $? -ne 0 ]; then
    echo 'Unable to find latest version for awscli'
    exit 1
fi

echo "Latest version is $latest"

wget -q https://api.github.com/repos/BastienAr/docker-awscli/git/refs/tags/$latest -O - > /dev/null 2>1
if [ $? -eq 0 ]; then
    echo "$latest has already been deployed"
    exit 78
fi

docker build --build-arg AWS_CLI_VERSION=$latest -t banst/awscli:$latest -t banst/awscli:latest .
echo "{\"ref\": \"refs/tags/$latest\", \"sha\": \"$GITHUB_SHA\""