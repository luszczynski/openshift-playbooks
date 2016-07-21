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

`vars.yaml` example:
```yaml
---
subdomain: cloudapps.example.com
domain: example.com
number_of_nodes: 3
remove_images_on_cleanup: False
user: admin # this user needs to be cluster admin
pass: redhat

secure_registry: False
expose_router_metrics: False

http_proxy:
https_proxy:
no_proxy:
user_proxy:
pass_proxy:

sdn_range: 10.1.0.0/16
service_ip_range: 172.30.0.0/16
```

Clone this repo.
```bash
git clone https://github.com/luszczynski/openshift-playbooks && cd openshift-playbooks
```
### Installing router, registry, metrics and logging
```bash
ansible-playbooks -i hosts.ini router_install.yaml registry_install.yaml metrics_install.yaml logging_install.yaml
```

### Installing only some components
```bash
# Installing router
# If you want router metrics, set expose_router_metrics to True in vars.yaml
ansible-playbooks -i hosts.ini router_install.yaml

# Installing registry
# If you want to secure registry, set secure_registry to True in vars.yaml
ansible-playbooks -i hosts.ini registry_install.yaml

# Installing metrics
ansible-playbooks -i hosts.ini metrics_install.yaml

# Installing logging
ansible-playbooks -i hosts.ini logging_install.yaml
```

### Uninstalling router, registry, metrics and logging
```bash
ansible-playbooks -i hosts.ini cleanup.yaml
```

### Uninstalling only some components
```bash
# Uninstalling router
ansible-playbooks -i hosts.ini cleanup.yaml --tags=router

# Uninstalling registry
ansible-playbooks -i hosts.ini cleanup.yaml --tags=registry

# Uninstalling metrics
ansible-playbooks -i hosts.ini cleanup.yaml --tags=metrics

# Uninstalling logging
ansible-playbooks -i hosts.ini cleanup.yaml --tags=logging
```

### Some other actions

#### Clean up your cluster
You can clean stopped containers and also remove images from registry in order to release some space on disk.

```bash
ansible-playbooks -i hosts.ini clean_docker.yaml
```

#### Configure GC on Openshift

Coming soon

#### Openshift installation pre-req

Coming soon
