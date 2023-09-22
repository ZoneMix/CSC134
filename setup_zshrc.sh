#!/bin/bash

if ! alias | grep -q "alias msf-run="; then
    echo "alias msf-run=\"docker run -it tleemcjr/metasploitable2:latest sh -c \"/bin/services.sh\"\""
fi
