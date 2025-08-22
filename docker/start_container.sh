#!/usr/bin/env bash

set -euo pipefail

image=nvim
ver=24.04

docker run --rm -it -v $(pwd):$(pwd) -w $(pwd) davetang/${image}:${ver} /bin/bash
