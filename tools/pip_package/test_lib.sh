#!/usr/bin/env bash

set -e

if [[ $# -lt 1 ]] || [[ ! "$1" == "GPU" ]] && [[ ! "$1" == "CPU" ]]; then
    echo "Usage: $(basename $0) <DEVICE>[CPU|GPU]"
    exit 1
fi

virtualenv pip_release
source pip_release/bin/activate
pip install -U pip dist/*.whl nose
git clone --recursive http://github.com/dmlc/mxnet.git mxnet-build
cd mxnet-build
if [ "$1" == "GPU" ]; then
    nosetests tests/python/gpu/
else
    nosetests tests/python/unittest/
fi