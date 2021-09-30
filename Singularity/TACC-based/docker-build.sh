#!/usr/bin/env bash
# A simple script for building the WRF 4.2.2 Intel (with Intel MPI) container based on 
#   TACC's Ubuntu 18 Intel 19 base image

export BUILD_OUTPUT_FILE=./output_TACC_build.txt
export CURRENT_TAG=4.2.2-TACC-069ac60cfb07
echo "**WRF Intel Docker for Stampede2** Build started, output in ${BUILD_OUTPUT_FILE}"

# Save build output log instead of printing to the screen
#docker build --network=host --tag cornellcac/wrf:${CURRENT_TAG} ./ 2>&1 > $BUILD_OUTPUT_FILE

# Uncomment below to save build output log AND print to screen
docker build --network=host --tag cornellcac/wrf:${CURRENT_TAG} ./ 2>&1 | tee $BUILD_OUTPUT_FILE

# Some useful summary output
echo "-------------------------------------------------------------"
echo "Build complete.  Check output file for final status.  Possible Errors:"
cat $BUILD_OUTPUT_FILE | grep ERROR
cat $BUILD_OUTPUT_FILE | grep Error
echo "-------------------------------------------------------------"
echo "Tail of build output file:"
cat $BUILD_OUTPUT_FILE | tail

