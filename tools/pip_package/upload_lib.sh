#!/usr/bin/env bash

set -e

ve_name=pip_release

virtualenv ${ve_name}
source ${ve_name}/bin/activate
pip install -U pip twine pypandoc
cp ./.pypirc ~/
python -c 'from pypandoc.pandoc_download import download_pandoc; download_pandoc()' # installing here because if installed as root we can't read from different user
export mxnet_variant=CU80 && python setup.py register -r https://testpypi.python.org/pypi
twine upload dist/* -r pypitest