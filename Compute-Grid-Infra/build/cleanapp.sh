#!/bin/bash

if [ $# -eq 2 ]; then
    echo $0: usage: myscript resourcegroupname managedappname managedapprg
    exit 1
fi

if [ $# -eq 0 ]; then
    echo $0: usage: myscript resourcegroupname managedappname managedapprg
    exit 1
fi
rgname=$1
az group delete --name $rgname

if [ $# -eq 3 ]; then
az managedapp definition delete --name $2 -g $3
fi