#!/bin/bash

# Set the path to the folder containing the images
input_folder="./input/future-scenarios"
output_folder="./output/future-scenarios-cropped"


# Set the coordinates and dimensions of the rectangle
x=0
y=300
width=3600
height=1800

# Set the size of the output images
max_size=1920

mkdir -p "$output_folder"


# Loop through all the images in the folder and crop and resize them
for file in "$input_folder"/*; do
    if [[ -f "$file" ]]; then
        # Get the filename and extension of the image
        filename=$(basename "$file")
        extension="${filename##*.}"
        filename="${filename%.*}"
        
        # Crop the image to the specified rectangle
        convert "$file" -crop "${width}x${height}+${x}+${y}" \
            -resize "${max_size}x${max_size}>" \
            "${output_folder}/${filename}.${extension}"
    fi
done
