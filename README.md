# Openshift playbooks

This repo contains playbooks to automate some basic tasks necessary during openshift installation.
There are also tasks that help to maintain your cluster.

* Playbooks were tested only on an openshift environment without HA (1 master and 2 nodes)

## Pre-req
You need `ansible` installed on your machine. If you're using these playbooks on `openshift`, clone this repo on master and you're ready to go.

## Usage

You need to update `hosts.ini` and `var.yml` according to your environment

`hosts.ini` example:
```
[master]
10.1.1.20

[nodes]
10.1.1.21
10.1.1.22
```

`vars.yml` example:
```yaml
---
subdomain: cloudapps.example.com
domain: example.com
number_of_nodes: 3
remove_images_on_cleanup: false
user: admin # this user needs to be cluster admin
pass: redhat

#Registry
secure_registry: false
ha_registry: false

# Router
expose_router_metrics: false
ha_router: false

http_proxy:
https_proxy:
no_proxy:
user_proxy:
pass_proxy:

sdn_subnet: 10.1.0.0/16
service_subnet: 172.30.0.0/16

rhn_user:
rhn_pass:
```

Clone this repo.
```bash
git clone https://github.com/luszczynski/openshift-playbooks && cd openshift-playbooks
```
### Installing router, registry, metrics and logging
```bash
ansible-playbooks -i hosts.ini install.yml
```

### Installing only some components
```bash
# Installing router
# If you want router metrics, set expose_router_metrics to true in vars.yaml
ansible-playbooks -i hosts.ini install.yml --tags=router

# Installing registry
# If you want to secure registry, set secure_registry to true in vars.yaml
ansible-playbooks -i hosts.ini install.yml --tags=registry

# Installing metrics
ansible-playbooks -i hosts.ini install.yml --tags=metrics

# Installing logging
ansible-playbooks -i hosts.ini install.yml --tags=logging

# Instaling router and registry
ansible-playbooks -i hosts.ini install.yml --tags=router,registry
```

### Uninstalling router, registry, metrics and logging
```bash
ansible-playbooks -i hosts.ini uninstall.yml
```

### Uninstalling only some components
```bash
# Uninstalling router
ansible-playbooks -i hosts.ini uninstall.yml --tags=router

# Uninstalling registry
ansible-playbooks -i hosts.ini uninstall.yml --tags=registry

# Uninstalling metrics
ansible-playbooks -i hosts.ini uninstall.yml --tags=metrics

# Uninstalling logging
ansible-playbooks -i hosts.ini uninstall.yml --tags=logging

# Uninstalling router and registry
ansible-playbooks -i hosts.ini uninstall.yml --tags=router,registry
```

### Some other actions

#### Clean up your cluster
You can clean stopped containers and also remove images from registry in order to release some space on disk.

```bash
ansible-playbooks -i hosts.ini tasks/others/clean_docker.yml
```

#### Openshift installation pre-req

You can automate openshift prerequisites using the following playbook.

* Remember you need to set `rhn_user` and `rhn_pass` inside `vars.yml` before running this playbook

```bash
ansible-playbooks -i hosts.ini tasks/pre_install/pre_req.yml
```

#### Configure GC on Openshift

Coming soon

#### Configuring proxy on Openshift

Coming soon
