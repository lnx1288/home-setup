#!/bin/bash

# current dir shenanigans
cd "$(dirname "$0")"  # cd into the script dir
ROOT_DIR=$PWD/../

# set up vars
. ${ROOT_DIR}configs/vars

# launch deployment host
if lxc profile show "$DEP_HOST_NAME-profile" &> /dev/null; then
    echo "ERROR: Profile exists, please delete $DEP_HOST_NAME-profile and retry"
    exit
else
    lxc profile create "$DEP_HOST_NAME-profile"
fi
cat ${ROOT_DIR}configs/deployment-host-profile | lxc profile edit "$DEP_HOST_NAME-profile"
lxc launch -p "$DEP_HOST_NAME-profile" ubuntu:$DEP_HOST_OS_RELEASE $DEP_HOST_NAME
