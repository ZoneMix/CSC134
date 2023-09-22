#!/bin/bash

if ! alias | grep "msf-run="; then
    echo "alias msf-run=\"docker run -it tleemcjr/metasploitable2:latest\"" >> ~/.zshrc
fi
