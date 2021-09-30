#!/usr/bin/env bash
# A simple script for building the Intel (with Intel MPI) container

export BUILD_OUTPUT_FILE=./output_intel_build.txt
echo "**WRF Intel Docker** Build started, output in ${BUILD_OUTPUT_FILE}"

# Save build output log instead of printing to the screen
#docker build --network=host --tag cornellcac/wrf:4.2.2-intel-7415915e0b8e - < Dockerfile-Intel 2>&1 > $BUILD_OUTPUT_FILE

# Uncomment below to save build output log AND print to screen
docker build --network=host --tag cornellcac/wrf:4.2.2-intel-7415915e0b8e - < Dockerfile-Intel 2>&1 | tee $BUILD_OUTPUT_FILE

# Some useful summary output
echo "-------------------------------------------------------------"
echo "Build complete.  Check output file for final status.  Possible Errors:"
cat $BUILD_OUTPUT_FILE | grep ERROR
cat $BUILD_OUTPUT_FILE | grep Error
echo "-------------------------------------------------------------"
echo "Tail of build output file:"
cat $BUILD_OUTPUT_FILE | tail
