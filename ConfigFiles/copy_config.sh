#!/bin/bash

ConfigArray=('/etc/default/grub')

for i in ${ConfigArray[@]}; do
    echo "Copying ${i}"
    cp ${i} .
done
