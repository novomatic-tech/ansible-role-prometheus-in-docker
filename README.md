[![Build Status](https://travis-ci.org/novomatic-tech/ansible-role-prometheus-in-docker.svg?branch=master)](https://travis-ci.org/novomatic-tech/ansible-role-prometheus-in-docker) [![License](https://img.shields.io/badge/license-Apache%202-green.svg)](https://github.com/novomatic-tech/ansible-role-prometheus-in-docker/blob/master/LICENSE) [![Ansible Role Name](https://img.shields.io/ansible/role/42983.svg)](https://galaxy.ansible.com/novomatic-tech/prometheus_in_docker) [![Ansible Role counter](https://img.shields.io/ansible/role/d/42983.svg)](https://galaxy.ansible.com/novomatic-tech/prometheus_in_docker)
# ansible-role-prometheus-in-docker
A role to install and configure the prometheus base on official containers and some community containers.
The role is used in our organization for different testing purposes and demo environments.


Role Variables
--------------

All default variables are predefined in [defaults/main.yml](defaults/main.yml).


Example Playbook
----------------

Example playbook usage:

```
- hosts: ubuntu18
  vars:
    prometheus_persistence_enabled: true
    prometheus_custom_config_enabled: false

    prometheus_compose_files_path: "/etc/compose-files"
    prometheus_configuration_path: "{{ prometheus_compose_files_path }}/env/prometheus/conf"
    prometheus_persistence_path: "{{ prometheus_compose_files_path }}/data/prometheus"
   ansible_become: yes
  roles:
    - geerlingguy.docker
    - ansible-role-prometheus-in-docker
```

If setting `prometheus_custom_config_enabled` flag to true - ansible will look for config template `prometheus.yml.j2` - ansible will use its own precedence order.
```bash
    /ansible/roles/prometheus_in_docker/templates/prometheus.yml.j2
    /ansible/roles/prometheus_in_docker/prometheus.yml.j2
    /ansible/roles/prometheus_in_docker/tasks/templates/prometheus.yml.j2
    /ansible/roles/prometheus_in_docker/tasks/prometheus.yml.j2
    /ansible/playbooks/templates/prometheus.yml.j2
    /ansible/playbooks/prometheus.yml.j2
```
You can provide it:
- (dirty) Add it explicitly in download role catalogue.
- Create catalogue in `playbook` directory - `templates` and there create this template file 

License
-------

Apache 2.0

Author Information
------------------

This role was created in 2019 for the purposes of Novomatic Technologies Poland.

