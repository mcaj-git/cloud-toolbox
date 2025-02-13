#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

IMAGE_TAG="latest"
TOOLBOX_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

#functions
function startNewToolbox {
  docker pull insecurit/cloud-toolbox:$IMAGE_TAG
  docker run -ti --rm \
    --name toolbox \
    -v ~/.kube:/root/.kube \
    -v ~/.helm:/root/.helm \
    -v ~/.ssh:/root/.ssh \
    -v ${PWD}:/root/dev \
    -v ~/.gitconfig:/root/.gitconfig \
    -v $TOOLBOX_DIR/.autoexec.sh:/root/.autoexec.sh \
    -v ~/.aws:/root/.aws \
    -v ~/.azure:/root/.azure \
    -v ~/.config/gcloud:/root/.config/gcloud \
    -v ~/ca-certificates:/usr/local/share/ca-certificates/extra \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --env-file <(env | grep -i proxy) \
    insecurit/cloud-toolbox:$IMAGE_TAG \
    /bin/zsh
}

function attachToToolbox {
  docker exec -it toolbox /bin/bash
}

if [[ "$(docker ps -a | grep toolbox)" ]]
then
    attachToToolbox
else
    startNewToolbox
fi
