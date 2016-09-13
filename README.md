# Openshift playbooks

This repo contains playbooks to automate some basic tasks necessary during openshift installation. There are also tasks that help to maintain your cluster.

* These playbooks were tested only on an openshift environment without HA (1 master and 2 nodes)

## Pre-req

You need `ansible` installed on your machine. If you're using these playbooks on `openshift`, clone this repo on master and you're ready to go.

## Usage

Clone this repo.
```bash
git clone https://github.com/luszczynski/openshift-playbooks && cd openshift-playbooks
```

You need to update `hosts.ini` and `group_vars/all.yml` according to your environment

`hosts.ini` example:
```
[master]
10.1.1.20

[nodes]
10.1.1.21
10.1.1.22

[infra]

[nfs]

[dns]
```

`all.yml` example:
```yaml
---
################
### Clean up ###
################
remove_images_on_cleanup: false

# Remove old builds and deployments
prune_builds_deployments: true

# Remove old images on registry
prune_register_images: true

############
### Auth ###
############
user: openshift
pass: openshift

# This user needs to be a cluster-admin and image pruner (oadm policy add-role-to-user cluster-admin superuser && oadm policy add-cluster-role-to-user system:image-pruner superuser)
# It will be used to clean the registry
user_cluster: admin
pass_cluster: redhat@123

###########
### DNS ###
###########
# Install a DNS server (bind)
install_dns: false

################
### Registry ###
################
# Secure and expose registry with certs
secure_registry: false

# Install ha registry
registry_ha: false

# Selector used to schedule registry
registry_selector: region=infra

# If you want to install registry on master. If true, registry_selector will be ignored
install_registry_on_master: true

##############
### Router ###
##############
# Expose router metrics
expose_router_metrics: false

# Install ha router
router_ha: false

# Selector used to schedule router
router_selector: region=infra

# If you want to install router on master. If true, router_selector will be ignored
install_router_on_master: true

###############
### Metrics ###
###############
# Selector used to schedule metrics components
metrics_selector: region=infra

#############
### Proxy ###
#############
http_proxy:
https_proxy:
no_proxy:
proxy_user:
proxy_pass:
proxy_port:

###############
### Network ###
###############
sdn_subnet: 10.1.0.0/16
service_subnet: 172.30.0.0/16

####################
### Subscription ###
####################
rhn_user:
rhn_pass:

```

### Installing router, registry, metrics and logging at once
```bash
ansible-playbooks -i hosts.ini install.yml
```

### Installing only some components
```bash

# Installing router
# If you want router metrics, set expose_router_metrics to true in all.yml
ansible-playbooks -i hosts.ini install.yml --tags=router

# Installing registry
# If you want to secure registry, set secure_registry to true in all.yml
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
ansible-playbooks -i hosts.ini others/clean.yml
```

#### Openshift installation pre-req

You can automate openshift prerequisites using the following playbook.

* Remember you need to set `rhn_user` and `rhn_pass` inside `group_vars/all.yml` before running this playbook

```bash
ansible-playbooks -i hosts.ini install.yml --tags=pre-install
```

#### Configure GC on Openshift

Coming soon

#### Configuring proxy on Openshift

Coming soon
