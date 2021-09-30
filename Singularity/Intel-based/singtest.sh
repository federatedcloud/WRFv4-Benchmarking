#!/bin/bash
#SBATCH -p skx-dev
#SBATCH -N 1
#SBATCH -n 36
#SBATCH -t 00:30:00
#SBATCH -A ADD_PROJECT_NAME_HERE
#SBATCH -J wrf4-singtest-singlenode

## Slurm script for funning a test with Singularity

# Load system modules
module reset # Should include intel/18.0.2 impi/18.0.2
module load tacc-singularity/3.7.2 netcdf/4.6.2 pnetcdf/1.11.0 phdf5/1.10.4

# Container image with path
CONTAINER=./wrf_4.2.2.sif

# Testing
which singularity

echo "Test simple MPI program: 1 process"
singularity exec ${CONTAINER} mpicc /opt/intel/oneapi/mpi/2021.2.0/test/test.c -o /opt/intel/oneapi/mpi/2021.2.0/test/test
singularity exec ${CONTAINER} mpirun -n 1 /opt/intel/oneapi/mpi/2021.2.0/test/test

echo "Test simple MPI program: 2 processes"
singularity exec ${CONTAINER} mpirun -n 2 /opt/intel/oneapi/mpi/2021.2.0/test/test

# Run WRF
echo "Test WRF"
singularity exec ${CONTAINER} /opt/wrf/WRF/run/wrf.exe

## Need to move to using mpirun or ibrun, also time and/or profiler (vtune)
#time mpirun -np 48 ./WRF/run/wrf.exe
#time ibrun ./wrf.exe

