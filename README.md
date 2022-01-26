## Instructions

### Pre-requisites

  - LXD installed on local machine

### Physical server(s) OS installation
Install some required dependencies:
`sudo apt install xorriso sed curl gpg isolinux`

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

`./ubuntu-autoinstall-generator.sh -a -u <PATH>/autoinstall-config.yaml -d <MY_IMAGE>.iso`

Change `PATH` and `MY_IMAGE` as needed.

Make a bootable USB with the resulting ISO, i.e., `<MY_IMAGE>.iso`

Boot the server and wait until the installation finishes (~10min). 

__NOTE__:You may want to remove the residouos OS images downloaded by 
`ubuntu-autoinstall-generator.sh` to save storage space on your local 
machine.

### Setup deployment host

The script below will deploy an LXD container within your local machine using
the config values within `configs/vars` (change this file as per your needs). 

`./scripts/setup-deployment-host.sh`

The script will add an entry with the deployment container IP will to your 
local `/etc/hosts` for hostname resolution convenience. 


### TO-DOs

  - Configure node after deployment (Ansible?)
    - needed packages
    - hardening
    - set up DNS resolution (/ect/hosts)
  - Configure K8s installation
  - Deploy services 
    - Owncloud
    - Backup Server
    - Logging
    - Management



### Useful links

 * [Ubuntu autoinstall ISO with cloud-init](https://www.pugetsystems.com/labs/hpc/How-To-Make-Ubuntu-Autoinstall-ISO-with-Cloud-init-2213/)
 * [ubuntu-autoinstall-generator tool](https://github.com/covertsh/ubuntu-autoinstall-generator)
 * [Useful full-disk config for automated Ubuntu install](https://itectec.com/ubuntu/ubuntu-how-to-autoinstall-config-fill-disk-option-on-ubuntu-20-04-automated-server-insall/