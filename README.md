## Kubernetes cluster using ansible

This repo allows you to install  and configure a Kubernetes cluster using
physical servers. The following tasks are accomplished:
  * Build a custom ISO to install the OS on the physical servers
  * Launch and configure an LXD container as deployment host
  * Configure SSH access from the deployment host to all nodes and viceversa
  * Install and initialize the Kubernetes cluster (if there's only one node,
it will be configured as both master and worker) 

### Pre-requisites

  - LXD installed on local machine

### Physical server(s) OS installation
Install some required dependencies:

```
sudo apt install xorriso sed curl gpg isolinux
```

Get and run the script that adds all the configs intos the ISO

```
git clone https://github.com/covertsh/ubuntu-autoinstall-generator.git
cd ubuntu-autoinstall-generator
sudo chmod +x ubuntu-autoinstall-generator.sh
```

Create/modify the `yaml` file for 
[Ubuntu Autoinstall](https://ubuntu.com/server/docs/install/autoinstall) to use.

__NOTE__: to encrypt the user password you may use this command: `mkpasswd --method=SHA-512 --rounds=4096`   

Run `ubuntu-autoinstall-generator.sh` 

```
./ubuntu-autoinstall-generator.sh -a -u <PATH>/autoinstall-config.yaml -d <MY_IMAGE>.iso
```

Change `PATH` and `MY_IMAGE` as needed.

Make a bootable USB with the resulting ISO, i.e., `<MY_IMAGE>.iso`

Boot the server and wait until the installation finishes (~10min). 

__NOTE__:You may want to remove the residouos OS images downloaded by 
`ubuntu-autoinstall-generator.sh` to save storage space on your local 
machine.

### Launch deployment host

The script below will deploy an LXD container within your local machine using
the config values within `configs/vars` (change this file as per your needs). 

```
./scripts/setup-deployment-host.sh
```

### Configure and install deployment host and nodes

SSH into the deployment host and move to the repo directory:

```
lxc exec dep-host bash
cd home-setup
```

Adapt the Ansible inventory file within the repo directory (i.e., 
`ansible/hosts`) to match your environment, i.e., add the host(s) to the 
approppriate groups.

Run the main ansible playbook:

```
  ansible-playbook -i ansible/hosts --ask-vault-password ansible/main.yaml
```

This playbook will do the following:



### Steps and TO-DOs

  - Automate physical server installation - Done
  - Automate deployment host setup - Done
  - Initial configurations for deployment host
    - DNS resolution via /etc/hosts - Done
    - Key-based SSH access to node(s) - Done
    - Base package installation - Done
  - Initial configurations for physical node(s)
    - Hardening
    - Package installation
      - Kubernetes
      -
    - 
  - Workload/services deployment
    - Cloud storage solution (Owncloud?)
    - Backup solution
    - Logging, Monitoring & Alerting

### References

 * [Ubuntu autoinstall ISO with cloud-init](https://www.pugetsystems.com/labs/hpc/How-To-Make-Ubuntu-Autoinstall-ISO-with-Cloud-init-2213/)
 * [ubuntu-autoinstall-generator tool](https://github.com/covertsh/ubuntu-autoinstall-generator)
 * [Useful full-disk config for automated Ubuntu install](https://itectec.com/ubuntu/ubuntu-how-to-autoinstall-config-fill-disk-option-on-ubuntu-20-04-automated-server-insall/)

 ### Acknowledgements

Based on the work below:

  * Aristides Gonzalez - [dockershame](https://github.com/ariguillegp/dockershame) 
  * Jeff Geerling - [ansible-role-kubernetes](https://github.com/geerlingguy/ansible-role-kubernetes)