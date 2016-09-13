#!/bin/bash

oc patch dc docker-registry --type='json' -p="[{\"op\": \"replace\", \"path\": \"/spec/template/spec/containers/0/image\", \"value\":\"registry.access.redhat.com/openshift3/ose-docker-registry:$1\"}]"
