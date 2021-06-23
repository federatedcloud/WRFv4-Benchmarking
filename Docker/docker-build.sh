#!/usr/bin/env bash
# A simple script for building the container

export BUILD_OUTPUT_FILE=./build_output.txt
echo "Build started, output in ${BUILD_OUTPUT_FILE}"

# Save build output log instead of printing to the screen
#docker build --network=host --tag cornellcac/wrf:4.2.2 ./ 2>&1 > $BUILD_OUTPUT_FILE

# Uncomment below to save build output log AND print to screen
docker build --network=host --tag cornellcac/wrf:4.2.2 ./ 2>&1 | tee $BUILD_OUTPUT_FILE

# Some useful summary output
echo "-------------------------------------------------------------"
echo "Build complete.  Check output file for final status.  Errors:"
cat build_output.txt | grep ERROR
cat build_output.txt | grep Error
echo "-------------------------------------------------------------"
echo "Tail of build output:"
cat build_output.txt | tail
