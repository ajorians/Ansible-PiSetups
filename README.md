# Ansible-PiSetups
Setup Playbooks For Home Raspberry Pis.

If you haven't already for your user locally run: ssh-keygen -b 4048 -t rsa -C "root login" -N ""

That doesn't use a password

To persist it: ssh-copy-id root@server

## Usage
You can run a playbook on a subset of the machines like so:
ansible-playbook -i inventory.ini BasicSetupSteps.yml --ask-vault-pass --limit 'asterisk'

## Files
Task/* - Tasks Playbooks.  Some tweaked for a particular host; should probably make generic
Docker/* - Specific Playbooks that setup a Docker container
Backups/* - Playbooks that configure backing up or restoring from a backup

BasicSetupSteps.yml - Playbook with setup that all machines ought to be using.
