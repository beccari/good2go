#!/bin/bash

set -euo pipefail

########################
### Based on Ansible ###
########################

echo "Automated shell script + Ansible to prepare your Ubuntu for development"

echo "Checking if ansible is installed..."

if ! [ -x "$(command -v ansible)" ]; then
    echo "Installing ansible..."
    sudo apt update
    sudo apt install git software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt --assume-yes install ansible
    # make sure we have the community general collection
    sudo ansible-galaxy collection install community.general
fi


echo "Running playbook on this very machine"
ansible-playbook --connection=local --inventory 127.0.0.1, --limit 127.0.0.1 playbooks/main.yml

