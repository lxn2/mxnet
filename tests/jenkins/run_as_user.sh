#!/bin/bash

if [[ ! $1 || ! $2 || ! $3 || ! $4 ]];
then
    echo "USAGE: " $(basename $"0") "USER_ID USER_NAME GROUP_ID GROUP_NAME"
    exit 1
fi

USER_ID=$1
USER_NAME=$2
GROUP_ID=$3
GROUP_NAME=$4

groupadd -f -g ${GROUP_ID} ${GROUP_NAME}
useradd -m -u ${USER_ID} -g ${GROUP_NAME} ${USER_NAME}
chown -R ${USER_NAME}:${GROUP_NAME} /home/${USER_NAME}
su -m ${USER_NAME} -c tests/jenkins/run_test_amzn_linux_gpu.sh
