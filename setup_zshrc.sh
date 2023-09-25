#!/bin/bash

MSF_RUN=$(grep "msf-run" $HOME/.zshrc)

if [ -z "$MSF_RUN" ]; then
    echo "alias msf-run=\"docker run -it tleemcjr/metasploitable2:latest\"" >> ~/.zshrc
fi
