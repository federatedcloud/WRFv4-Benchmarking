# Singularity Container for WRF 4.2.2

This container was built using the Intel Compiler, and is configured for use with Intel MPI.
The Singularity container is built based on the Docker container in this same repository.
The Singularity definition file (called `Singularity`) is pulling the Docker image 
[cornellcac/wrf:4.2.2](https://hub.docker.com/repository/docker/cornellcac/wrf) from DockerHub.

## System Requirements for Using This Container

* Singularity 3.5 or above [installed](https://sylabs.io/guides/3.5/admin-guide/installation.html)
* Disk space large enough space to accommodate the container image.  The Docker base image is quite large (~25 GB).
* Intel MPI installed, preferably the version available in the [Intel OneAPI HPC Toolkit](https://software.intel.com/content/www/us/en/develop/documentation/get-started-with-intel-oneapi-hpc-linux/top.html).
* Set the following environment variables to enable Intel MPI on your system:
```
export I_MPI_CC=icc
export I_MPI_CXX=icpc
export I_MPI_F77=ifort
export I_MPI_F90=ifort
``` 

## Build the Singularity Container

1. Make sure your system meets the above requirements.
2. Clone this repository and checkout this branch
```
git clone https://github.com/federatedcloud/WRFv4-Benchmarking.git
git checkout sing
```
3. Build the `image.sif` from the definition file `Singularity`
```
sudo singularity build image.sif Singularity
```

Please note that the base image is quite large (~25 GB), so testing a build can a while.

## Test the Container

Once your system meets the above requirements and you have built the container, you can try testing.

### Basic MPI Test


### Verify WRF Install


### Run the CONUS Benchmarks


