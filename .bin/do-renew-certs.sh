#!/usr/bin/env zsh

# echo "gr.ht" | sed 's/.*\.\(\w\+\.\w\+$\)/\1/'

if [ "$#" -eq 3 ]; then
	doctl compute domain records create $3 --record-type TXT --record-name _acme-challenge.${1}. --record-data $2 
else
	doctl compute domain records create $1 --record-type TXT --record-name _acme-challenge.${1}. --record-data $2 
fi

