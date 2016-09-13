#!/bin/bash

oc patch dc router --type='json' -p="[{\"op\": \"replace\", \"path\": \"/spec/template/spec/containers/0/image\", \"value\":\"registry.access.redhat.com/openshift3/ose-haproxy-router:$1\"}]"
