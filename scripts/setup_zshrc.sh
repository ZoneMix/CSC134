#!/bin/bash

MSF_RUN=$(grep "msf-run" $HOME/.zshrc)
JUICE_RUN=$(grep "juice-run" $HOME/.zshrc)
BWAPP_RUN=$(grep "bwapp-run" $HOME/.zshrc)

if [ -z "$MSF_RUN" ]; then
    echo "alias msf-run=\"docker run -it tleemcjr/metasploitable2:latest\"" >> $HOME/.zshrc
fi

if [ -z "$JUICE_RUN" ]; then
	echo "alias juice-run=\"docker run --rm -p 3000:3000 bkimminich/juice-shop\"" >> $HOME/.zshrc
fi

if [ -z "$BWAPP_RUN" ]; then
	echo "alias bwapp-run=\"docker run -d -p 8081:80 raesene/bwapp\"" >> $HOME/.zshrc
fi
