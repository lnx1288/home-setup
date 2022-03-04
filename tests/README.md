## Test env

Launches VM-based test environments to test the repo. The VMs will use a 
configurable (`BASE_IMAGE` variable within the `Vagrantfile`) Ubuntu release 
as OS.

## Pre-requisites

  * Vagrant 
  * Vagrant plugins: vagrant-libvirt and vagrant-mutate
    * `vagrant plugin install vagrant-libvirt`
    * `vagrant plugin install vagrant-mutate`
  * Qemu/KVM installed/configured

Each node is configured with 2GB RAM + 1 vCPU. The single node deployment will 
create a VM with 4GB RAM + 2 vCPU.

### Available tests:

  * Test env 1: single-node K8s deployment 
  * (TO-DO) Test env 2: 1 master + 1 worker K8s deployment
  * (TO-DO) Test env 3: 2 master + 2 worker K8s deployment