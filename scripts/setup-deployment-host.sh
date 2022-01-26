#!/bin/bash

# current dir shenanigans
cd "$(dirname "$0")"  # cd into the script dir
ROOT_DIR=$PWD/../

# set up vars
. ${ROOT_DIR}configs/vars

# launch deployment host
LXD_PROFILE="$DEP_HOST_NAME-lxd-profile"

if lxc profile show "$LXD_PROFILE" &> /dev/null; then
    echo "ERROR: Profile exists, please delete $LXD_PROFILE and retry"
    exit
else
    lxc profile create $LXD_PROFILE
fi
cat "${ROOT_DIR}configs/$LXD_PROFILE" | lxc profile edit $LXD_PROFILE
lxc launch -p $LXD_PROFILE ubuntu:$DEP_HOST_OS_RELEASE $DEP_HOST_NAME
