#!/bin/bash
if [[ "$1" != d* ]]; then
	find ../ -type f -name "._*" 
else
	echo "Deleting"
	find ../ -type f -name "._*" -delete
	#find ../ -type f -name "._*" | xargs -0 rm -r 
	#find ../ -type f -name "._*" | sed 1d | xargs rm -r 
fi
