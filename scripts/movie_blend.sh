#!/bin/bash

# Specify the input and output directories
input_folder="./output/crop"
output_folder="./output/movie"

echo "STARTING"

# Specify the frame rate (in frames per second)
frame_rate=30

# Specify the degree of motion blur
blur_factor=20

# Create the output directory if it doesn't exist
mkdir -p "$output_folder"

# Loop through all the images in the input directory
for image in "$input_folder"/*.jpg; do
    
  # Get the filename and extension of the image
  filename=$(basename "$image")
  extension="${filename##*.}"

  echo "Processing $filename..."
  echo $(mktemp)

  # Create a temporary file for the blurred image
  temp_file=$(mktemp)

  # Apply the motion blur to the image using ffmpeg
  ffmpeg -i "$image" -filter_complex "[0:v]minterpolate='mi_mode=mci:me_mode=bilat:me=epzs:mc_mode=aobmc:vsbmc=1:fps=$frame_rate'" -y "$temp_file"


  # Add the blurred image to the output video
  ffmpeg -loop 1 -i "$temp_file" -r $frame_rate -t 0.04 -pix_fmt yuv420p -vf scale=1920:-2 -c:v libx264 -preset medium -crf 23 -an -y "$output_folder/blend.mp4"

  # Remove the temporary file
  rm "$temp_file"
done

echo "Conversion complete!"