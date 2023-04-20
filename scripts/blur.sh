#!/bin/bash

# Specify the input and output directories
input_file="./output/movie/20230407_204728_output.mp4"
output_file="./output/movie/blend.mp4"

ffmpeg -i input_file -filter:v "minterpolate='mi_mode=mci:mc_mode=aobmc:me_mode=bidir:me=epzs:mb_size=8'" -c:a copy output_file
