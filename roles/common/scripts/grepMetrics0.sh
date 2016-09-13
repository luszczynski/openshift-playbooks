#!/bin/bash

echo -n $(grep -1 IMAGE_VERSION /usr/share/openshift/examples/infrastructure-templates/enterprise/logging-deployer.yaml | grep 'value: "' | cut -d\" -f2)
