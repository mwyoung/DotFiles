#!/bin/bash
#source: https://engineering.giphy.com/how-to-make-gifs-with-ffmpeg/
ffmpeg -i $1 -filter_complex \
    "[0:v] fps=8,scale=360:-1,split [a][b];[a] palettegen=stats_mode=single [p];[b][p] paletteuse=new=1" \
    "${1%.*}.gif"

