#!/usr/bin/env bash

set -euo pipefail

DIR=$(dirname $(realpath $0))
NVIM=${HOME}/.config/nvim
CONF=${HOME}/.config/nvim/init.vim

if [[ ! -d ${NVIM} ]]; then
   mkdir --verbose -p ${NVIM}
fi

if [[ ! -e ${CONF} ]]; then
   cp -v ${DIR}/init.vim ${CONF}
else
   >&2 echo ${CONF} already exists
fi

>&2 echo Done
exit 0
