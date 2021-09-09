#!/bin/bash
## Links files for running CONUS12km benchmarks to the working WRF directory.

DATA_LOCATION=$MAIN_DIR/data/v4_bench_conus12km
WRF_RUN_LOCATION=$WRF_SRC_ROOT_DIR/run
CONUS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

[ -f $CONUS_SCRIPT_DIR/CONUS12km_files ] || {
  echo "please make a list of files"
  exit 1
}

for realfile in $( cat $CONUS_SCRIPT_DIR/CONUS12km_files ); do
  ## For Debugging, uncomment the next line
  #echo "ln -s ${DATA_LOCATION}"$realfile" ${DATA_LOCATION}/$(basename $realfile)"

  ln -s ${DATA_LOCATION}/"$realfile" ${WRF_RUN_LOCATION}/$(basename $realfile)
done
