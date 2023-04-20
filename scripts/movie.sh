#!/bin/bash

# Set the path to the folder containing the images
input_folder="./output/crop-all"
output_folder="./output/movie"

# Set the frame rate for the output video
frame_rate=30

# Set the name of the output video file with a timestamp
timestamp=$(date +%Y%m%d_%H%M%S)
output_file="${output_folder}/${timestamp}_output.mp4"

# Use ffmpeg to convert the images to a video
ffmpeg -framerate "$frame_rate" -pattern_type glob -i "$input_folder/*.jpg" \
    -c:v libx264 -pix_fmt yuv420p "$output_file"
