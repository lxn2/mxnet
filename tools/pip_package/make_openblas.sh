#!/usr/bin/env bash

# download and build openblas
echo "Building openblas..."
curl -s -L https://github.com/xianyi/OpenBLAS/archive/v$OPENBLAS_VERSION.zip -o $DEPS_PATH/openblas.zip
unzip -q $DEPS_PATH/openblas.zip -d $DEPS_PATH
cd $DEPS_PATH/OpenBLAS-$OPENBLAS_VERSION
make --quiet NO_AVX2=1 -j $NUM_PROC || exit 1;
make PREFIX=$DEPS_PATH install;
cd -;
ln -s libopenblas.a $DEPS_PATH/lib/libcblas.a;
