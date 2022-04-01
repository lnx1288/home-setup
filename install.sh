#!/bin/bash

repo_root_dir=$(find $HOME -name home-setup 2> /dev/null)

set_vars(){
    # set up vars
    echo "Setting up variables from: $repo_root_dir/configs/vars"
    source "$repo_root_dir/configs/vars"
}

wait_for_repo(){
    echo "Waiting for the repo to be cloned into $DEP_HOST_NAME..."
    until lxc exec "$DEP_HOST_NAME" -- sh -c "ls $ansible_remote_dir 2> /dev/null"
    do
      echo -n "."
      sleep 3
    done
}

install(){

    set_vars

    echo "Setting up deployment host..."
    $repo_root_dir/scripts/setup-deployment-host.sh
    
    #home-setup is the git repo name as per the LXD profile created
    ansible_remote_dir="/root/home-setup/ansible/"
    wait_for_repo
    
    # push test host file
    lxc file push hosts "${DEP_HOST_NAME}${ansible_remote_dir}"
    # run playbooks
    lxc exec "$DEP_HOST_NAME" -- sh -c "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -vvv -i $ansible_remote_dir/hosts --ask-vault-password ${ansible_remote_dir}main.yaml"

}


getopts ":i" opt
    case "${opt}" in
         i) install;;
         *) echo -e "
     Usage: $0 -[i]

     Options:
             -i run all playbooks\n"; exit 1;;
    esac

exit 0