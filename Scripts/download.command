#!/bin/zsh
#For a MacOS system - downloads from m3u file
cd "$(dirname "$0")"

set -o extendedglob
if [[ -n *.txt(#qN) ]]; then
	file=(*.txt([1]))
elif [[ -n *.m3u(#qN) ]]; then
	file=(*.m3u([1]))
else
	echo "no file found"
fi

echo "Starting download"

while IFS= read -r line; do
	echo -e "\n$line"
	curl -L -O "$line"
done < $file 
