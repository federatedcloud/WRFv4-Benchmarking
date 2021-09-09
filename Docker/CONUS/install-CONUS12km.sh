#!/bin/bash
## Installs the CONUS12km benchmarks.

CONUS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

mkdir $MAIN_DIR/data
wget -P $MAIN_DIR/data https://www2.mmm.ucar.edu/wrf/users/benchmark/v4_bench_conus12km.tar.gz
tar -zxvf $MAIN_DIR/data/v4_bench_conus12km.tar.gz -C $MAIN_DIR/data
source $CONUS_SCRIPT_DIR/make_CONUS12km_links.sh
cp $CONUS_SCRIPT_DIR/CONUS12km-namelist.input $WRF_SRC_ROOT_DIR/run/namelist.input
source $CONUS_SCRIPT_DIR/runwrf-CONUS12km.sh

