#!/usr/bin/env bash

set -e

echo "In build_lib.sh"

if [[ $# -lt 1 ]]  || [[ ! "$1" == "CPU" ]] && [[ ! "$1" == "MKL" ]] && [[ ! "$1" == "CU75" ]] && \
    [[ ! "$1" == "CU80" ]]  && [[ ! "$1" == "CU75MKL" ]] && [[ ! "$1" == "CU80MKL" ]]; then
    SCRIPT=("$@")
    echo "Failing" $SCRIPT
    echo "Usage: $(basename $0) <VARIANT>[CPU|MKL|CU75|CU80|CU75MKL|CU80MKL]"
    exit 1
fi

virtualenv pip_release
source pip_release/bin/activate
pip install -U pip setuptools>=28.2 wheel pypandoc
python -c 'from pypandoc.pandoc_download import download_pandoc; download_pandoc()'
export mxnet_variant=$1 && tools/pip_package/make_standalone_libmxnet.sh $1;