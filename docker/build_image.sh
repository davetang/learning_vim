#!/usr/bin/env bash

set -euo pipefail

NAME=nvim
VER=24.04
SCRIPTDIR=$(dirname $0)

cd ${SCRIPTDIR} && docker build -t davetang/${NAME}:${VER} .

>&2 echo Build complete
>&2 echo -e "Run the following to push to Docker Hub:\n"
>&2 echo docker login
>&2 echo docker push davetang/${NAME}:${VER}

exit 0
