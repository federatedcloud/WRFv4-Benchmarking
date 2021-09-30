# WRF 4.2.2 Intel Singularity Containers

There are 2 types of Singularity containers here:
1. **Intel-based** - Singularity pulls in the image created from Docker container based on the Intel OneAPI HPC Toolkit container base image.
2. **TACC-based** - Singularity pulls in the Docker image built based off of TACC's base image [tacc/tacc-ubuntu18-impi19.0.7-common](https://github.com/TACC/tacc-containers#common-base-intel-mpi-images).

Both of these containers compile WRF 4.2.2 with Intel, but the first uses Intel 18 and the latter Intel 19.  The second also contains drivers and extra packages for TACC's Stampede2 supercomputer specifically that are unnecessary elsewhere (and thus less portable), but required for multinode Intel MPI to work there.


