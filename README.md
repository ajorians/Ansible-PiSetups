# Ansible-PiSetups
Setup Playbooks For Home Raspberry Pis.

If you haven't already for your user locally run: ssh-keygen -b 4048 -t rsa -C "root login" -N ""

That doesn't use a password

To persist it: ssh-copy-id root@server

## Usage
You can run a playbook on a subset of the machines like so:
ansible-playbook -i inventory.ini BasicSetupSteps.yml --ask-vault-pass --limit 'asterisk'

## Machines
ansible-playbook -i inventory.ini BackupSetup.yml --limit 'backups' --ask-vault-pass
ansible-playbook -i inventory.ini CMSSetup.yml --limit 'cms' --ask-vault-pass
ansible-playbook -i inventory.ini DownloadSetup.yml --limit 'download' --ask-vault-pass
ansible-playbook -i inventory.ini VPNSetup.yml --limit 'vpn' --ask-vault-pass

Mirrors isn't setup or ready yet.

## Files
Task/* - Tasks Playbooks.  Some tweaked for a particular host; should probably make generic
Docker/* - Specific Playbooks that setup a Docker container
Backups/* - Playbooks that configure backing up or restoring from a backup

BasicSetupSteps.yml - Playbook with setup that all machines ought to be using.
