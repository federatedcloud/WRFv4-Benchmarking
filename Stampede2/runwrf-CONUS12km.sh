#!/bin/bash
#SBATCH -p skx-dev
#SBATCH -N 1
#SBATCH -n 36
#SBATCH -t 01:00:00
#SBATCH -A ADD_PROJECT_NAME_HERE
#SBATCH -J wrf4-CONUS12-singlenode

# Load system modules
module reset # Should include intel/18.0.2 impi/18.0.2
module load netcdf/4.6.2 pnetcdf/1.11.0 phdf5/1.10.4

cd $WORK2/WRF_Benchmarking/WRFv4-Benchmarking/Stampede2/WRF/run

rm rsl.*

#time mpirun -np 48 ./WRF/run/wrf.exe
time ibrun ./wrf.exe

