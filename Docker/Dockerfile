FROM intel/oneapi-hpckit:devel-ubuntu18.04
# Intel OneAPI HPC Toolkit
# Ubuntu 18.04 base

MAINTAINER Peter Vaillancourt "pzv2@cornell.edu"

## Use bash for compile
## This Dockerfile compiles WRF from source during "docker build" step
SHELL ["/bin/bash","-c"]
ENV WRF_VERSION=4.2.2

## Ensuring only root user to prepare for singularity conversion
ARG USER=root
USER root
ARG HOME=/root

#ARG DEBIAN_FRONTEND=noninteractive  # Intel Dockerfile does this

RUN apt-get update -y && apt-get install -y \
    cmake \
    tcsh \
    wget \
    unzip \
    gawk \
    time \
    rsync

## For development
#RUN apt install -y \
#    man \
#    bash-completion \
#    vim \ 
#    htop \
#    tmux 

RUN mkdir /opt/wrf
RUN set -eux

## Set up some useful environment variables
ENV MAIN_DIR=/opt/wrf
ENV WRF_SRC_ROOT_DIR=${DIR}/WRF
ENV DIR=${MAIN_DIR}/LIBRARIES
ENV I_MPI_CC=icc
ENV I_MPI_CXX=icpc
ENV I_MPI_F77=ifort
ENV I_MPI_F90=ifort
ENV CC=mpicc
ENV CXX=icpc
ENV FC=mpif90
ENV FCFLAGS=-m64
ENV F77=mpif90
ENV FFLAGS=-m64
ENV JASPERLIB=$DIR/grib2/lib
ENV JASPERINC=$DIR/grib2/include
ENV LDFLAGS=-L$DIR/grib2/lib
ENV CPPFLAGS=-I$DIR/grib2/include
ENV PATH=$PATH:$DIR/grib2
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIR/grib2/lib

## Set environment for interactive container shells
RUN echo export I_MPI_CC=icc >> /etc/bashrc && \
    echo export I_MPI_CXX=icpc >> /etc/bashrc && \
    echo export I_MPI_F77=ifort >> /etc/bashrc && \
    echo export I_MPI_F90=ifort >> /etc/bashrc && \
    echo export CC=mpicc >> /etc/bashrc && \
    echo export CXX=icpc >> /etc/bashrc && \
    echo export FC=mpif90 >> /etc/bashrc && \
    echo export F77=mpif90 >> /etc/bashrc && \
    echo export LDFLAGS=-L$DIR/grib2/lib >> /etc/bashrc && \
    echo export JASPERINC=$DIR/grib2/include >> /etc/bashrc && \
    echo export JASPERLIB=$DIR/grib2/lib >> /etc/bashrc && \
    echo export OMP_STACK_SIZE=64000000 >> /etc/bashrc && \
    echo export CPPFLAGS=-I$DIR/grib2/include >> /etc/bashrc && \
    echo export PATH=$PATH:$DIR/grib2 >> /etc/bashrc && \
    echo export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIR/grib2/lib

## Install Libraries
WORKDIR $DIR

### zlib 1.2.7
RUN wget https://zlib.net/fossils/zlib-1.2.7.tar.gz && \
    tar -xzf zlib-1.2.7.tar.gz && \
    cd zlib-1.2.7 && \
    ./configure --prefix=$DIR/grib2 && \
    make && make install 

### libpng 1.2.50
RUN wget https://sourceforge.net/projects/libpng/files/libpng12/older-releases/1.2.50/libpng-1.2.50.tar.gz && \
    tar -xzf libpng-1.2.50.tar.gz && \
    cd libpng-1.2.50 && \
    ./configure --prefix=$DIR/grib2 && \
    make && make install

# Jasper 1.900.1
RUN wget https://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip && \
    unzip jasper-1.900.1.zip && \
    cd jasper-1.900.1 && \
    ./configure --prefix=$DIR/grib2 && \
    make && make install


## Install Dependencies
### NetCDF 4.6.2



### PNetCDF 1.11.0



### PHDF5 1.10.4
RUN wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.4/src/hdf5-1.10.4.tar.gz && \
    tar -xzf hdf5-1.10.4.tar.gz && \
    cd hdf5-1.10.4 && \
    ./configure --enable-fortran --enable-parallel --prefix=$DIR/PHDF5 && \
    make && make install && cd ..


## Install WRF
WORKDIR $MAIN_DIR

RUN wget https://github.com/wrf-model/WRF/archive/refs/tags/v4.2.2.tar.gz && \
    tar -zxf v4.2.2.tar.gz && \
    mv WRF-4.2.2/ WRF



#TODO: Fix TACC paths to container paths
#ENV PATH=${TACC_NETCDF_BIN}:${TACC_PNETCDF_BIN}:$PATH
#ENV NETCDF=${TACC_NETCDF_DIR}
#ENV PNETCDF=${TACC_PNETCDF_DIR}

ENV PHDF5=$DIR/PHDF5
ENV WRFIO_NCD_LARGE_FILE_SUPPORT=1
ENV WRF_EM_CORE=1
ENV KMP_STACKSIZE=512m

##ENV LDFLAGS="-lm -lnetcdff -lnetcdf -L${TACC_NETCDF_LIB}"
#ENV LDFLAGS="-lm -lnetcdff -lnetcdf -L${TACC_PNETCDF_LIB}"


## Set environment for interactive container shells
#RUN echo export LDFLAGS="-lm -lnetcdff -lnetcdf -lpnetcdf" >> /etc/bashrc && \
#    echo export PHDF5=/usr/include/hdf5/openmpi >> /etc/bashrc && \
#    echo export NETCDF=/wrf/netcdf_links >> /etc/bashrc && \
#    echo export PNETCDF=/wrf/pnetcdf_links >> /etc/bashrc && \
#    echo export JASPERINC=/usr/include/jasper/ >> /etc/bashrc && \
#    echo export JASPERLIB=/usr/lib/ >> /etc/bashrc && \
#    echo export WRFIO_NCD_LARGE_FILE_SUPPORT=1 >> /etc/bashrc && \
#    echo export WRF_EM_CORE=1 >> /etc/bashrc && \
#    echo export OMP_STACK_SIZE=64000000 >> /etc/bashrc && \
#    echo export LD_LIBRARY_PATH="/usr/lib/openmpi/lib" >> /etc/bashrc






## Install WPS?





## 

RUN ldconfig
 
