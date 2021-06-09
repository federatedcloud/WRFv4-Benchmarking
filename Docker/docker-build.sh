#!/usr/bin/env bash
# A simple script for building the Dpcler container

export BUILD_OUTPUT_FILE=./build_output.txt
echo "Build started, output in ${BUILD_OUTPUT_FILE}"
docker build --network=host ./ > $BUILD_OUTPUT_FILE
echo "Build complete.  Check output file for final status.  Errors:"
echo "-------------------------------------------------------------"
cat build_output.txt | grep ERROR
