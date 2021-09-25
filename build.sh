#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

IMAGE_TAG="2021-09-24_01"
UPSTREAM_TAG="latest"
UPSTREAM_TAG2="dev"

docker build \
    --pull \
    --no-cache \
    -t insecurit/cloud-toolbox:$IMAGE_TAG \
    .

#push
docker login
docker push insecurit/cloud-toolbox:$IMAGE_TAG

docker tag insecurit/cloud-toolbox:$IMAGE_TAG insecurit/cloud-toolbox:$UPSTREAM_TAG
docker push insecurit/cloud-toolbox:$UPSTREAM_TAG

docker tag insecurit/cloud-toolbox:$IMAGE_TAG insecurit/cloud-toolbox:$UPSTREAM_TAG2
docker push insecurit/cloud-toolbox:$UPSTREAM_TAG2
