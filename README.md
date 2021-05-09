# Provisioning Ansible

## Generate inventory 
`python3 fetchInventory.py --group_id {id}`

## Provision group
`docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa willhallonline/ansible:2.9-alpine ansible-playbook provisioning.yaml`