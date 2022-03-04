#!/bin/bash

repo_root_dir=$(find $HOME -name home-setup 2> /dev/null)

# set up vars
source "$repo_root_dir/configs/vars"

# launch deployment host
if lxc profile show "$LXD_PROFILE" &> /dev/null; then
    echo "ERROR: Profile exists, please delete $LXD_PROFILE and retry"
    exit
else
    lxc profile create $LXD_PROFILE
fi
cat "$repo_root_dir/configs/$LXD_PROFILE" | lxc profile edit $LXD_PROFILE
lxc launch -p $LXD_PROFILE ubuntu:$DEP_HOST_OS_RELEASE $DEP_HOST_NAME
lxc list
