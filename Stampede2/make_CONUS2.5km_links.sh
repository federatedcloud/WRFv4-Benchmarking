#!/bin/bash
  
DATA_LOCATION=$WORK2/WRF_Benchmarking/data/v4_bench_conus2.5km
WRF_RUN_LOCATION=$WORK2/WRF_Benchmarking/WRFv4-Benchmarking/Stampede2/WRF/run

[ -f CONUS2.5km_files ] || {
  echo "please make list of files"
  exit 1
}

for realfile in $( cat CONUS2.5km_files ); do
    ## For Debugging, uncomment the next line
    #echo "ln -s ${WRF_RUN_LOCATION}/"$realfile" ${DATA_LOCATION}/$(basename $realfile)"
    
    ln -s ${DATA_LOCATION}/"$realfile" ${WRF_RUN_LOCATION}/$(basename $realfile)
done
