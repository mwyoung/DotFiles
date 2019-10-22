#!/bin/bash

ConfigArray=('/etc/default/grub')

for i in ${ConfigArray[@]}; do
    cp ${i} .
done
