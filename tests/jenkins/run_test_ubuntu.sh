#!/bin/bash


SCRIPT_NAME=`basename "$0"`

if [[ $1 ]];
then
    if [[ $1 == "--help" ]];
    then
        echo "USAGE:"
        echo ${SCRIPT_NAME} "TASK"
        echo ""
	echo "TASK can be one of: lint, make, cpp, python, r, scala"
        exit 0
    fi
    TASK=$1
fi

if [[ ${TASK} == "lint" ]];
then
    echo "BUILD lint"
    make lint || exit 1
    exit 0
fi

if [[ ${TASK} == "make" ]];
then
    echo "BUILD make"
    cp make/config.mk .
    echo "USE_CUDA=1" >> config.mk
    echo "USE_CUDA_PATH=/usr/local/cuda" >> config.mk
    echo "USE_CUDNN=1" >> config.mk
    echo "USE_PROFILER=1" >> config.mk
    echo "DEV=1" >> config.mk
    echo "EXTRA_OPERATORS=example/ssd/operator" >> config.mk
    user=`id -u -n`
    make -j$(nproc) || exit 1
    exit 0
fi

if [[ ${TASK} == "cpp" ]];
then
    echo "BUILD cpp_test"
    make -j$(nproc) test || exit 1
    export MXNET_ENGINE_INFO=true
    #for test in tests/cpp/*_test; do
    #    ./$test || exit 1
    #done
    export MXNET_ENGINE_INFO=false
    exit 0
fi

if [[ ${TASK} == "python" ]];
then

    echo "BUILD python_test"
    nosetests --verbose tests/python/unittest || exit 1
    nosetests --verbose tests/python/gpu/test_operator_gpu.py || exit 1
    nosetests --verbose tests/python/gpu/test_forward.py || exit 1
    nosetests --verbose tests/python/train || exit 1

    echo "BUILD python3_test"
    nosetests3 --verbose tests/python/unittest || exit 1
    nosetests3 --verbose tests/python/gpu/test_operator_gpu.py || exit 1
    nosetests3 --verbose tests/python/gpu/test_forward.py || exit 1
    nosetests3 --verbose tests/python/train || exit 1

    exit 0
fi

if [[ ${TASK} == "r" ]];
then
    export CXX=g++
    export TRAVIS_OS_NAME=linux
    export CACHE_PREFIX=/tmp
    tests/travis/run_test.sh
    exit 0
fi

if [[ ${TASK} == "scala" ]];
then
    echo "BUILD scala_test"
    export PATH=$PATH:/opt/apache-maven/bin
    make scalapkg || exit 1
    make scalatest || exit 1
    exit 0
fi
