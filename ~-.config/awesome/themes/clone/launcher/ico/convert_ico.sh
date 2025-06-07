#!/bin/bash

mkdir -p png_out

for file in *.ico; do
    name="${file%.*}"
    convert "$file[0]" -resize 40x40 "png_out/${name}.png"
done
