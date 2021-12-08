# You're Good 2 Go, Ubuntu!

This is a very plain and stupid semi-automation script in order to setup your Ubuntu environment for development.

Since I did this too many times on diferent machines reading multiple docs with hundreds of steps I've decided to just go and automate my machine provision using `ansible` 
(see https://www.ansible.com/).

## Disclaimer

This tools is not official and does not replace any documentation. If much can serve as a reference of a list of required tools and dependencies developers are using.

Also, it is very important to understand that automation goes for repetitive unchallenging tasks, that everyone is tired to do, however keep in mind that you should be
able to execute any of these steps manually if required.


## Requisites

This works virtually on any Linux Ubuntu, but it was only tested on 21.10 Impish Indri


## How it works

It is quite simple, actually, just execute the main script file using sudo: `sudo ./good2go.sh`

> It is required to use sudo if you're not using `root`

Result is gonna be something like this:
```
beccari@freezegun:~/sandbox/good2go$ sudo ./good2go.sh 
[sudo] password for beccari: 

This is a semi-automated shell script, so do not expect too much of it

Running playbook on this very machine

PLAY [all] ***********************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************************************
ok: [127.0.0.1]

TASK [basic packages] ************************************************************************************************************************************************************************************************
ok: [127.0.0.1]

TASK [install basic dependencies] ************************************************************************************************************************************************************************************
ok: [127.0.0.1]

TASK [install docker] ************************************************************************************************************************************************************************************************
ok: [127.0.0.1]

TASK [python development packages] ***********************************************************************************************************************************************************************************
ok: [127.0.0.1]

TASK [nodejs development packages] ***********************************************************************************************************************************************************************************
ok: [127.0.0.1]

TASK [golang development packages] ***********************************************************************************************************************************************************************************
ok: [127.0.0.1]

PLAY RECAP ***********************************************************************************************************************************************************************************************************
127.0.0.1                  : ok=25   changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```


## My Extra Tasks

In case you want to extend the tasks but not changing anything, simple add `my-extra-tasks.yml` in *playbooks* directory.

This is useful if you want define some environment variable for instance:

```yml
- name: setup some very useful env var for {{ ansible_env.SUDO_USER }}
  become_user: "{{ ansible_env.SUDO_USER }}"
  blockinfile:
    path: /home/{{ ansible_env.SUDO_USER }}/.bashrc
    block: |
      # yes, this is useful actually
      export GTK_IM_MODULE=cedilla
      export QT_IM_MODULE=cedilla
    backup: yes
```

> This file is optional and just ignore the `failed=1` due "Could not find or access `...my-extra-tasks.yml`