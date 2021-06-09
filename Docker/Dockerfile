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

RUN apt update -y && apt install -y \
    cmake \
    tcsh \
    wget \
    unzip \
    rsync

## For development
#RUN apt install -y \
#    man \
#    bash-completion \
#    vim \ 
#    htop \
#    tmux 


RUN mkdir /opt/wrf
WORKDIR /opt/wrf

## Set up some useful environment variables
ENV DIR=/opt/wrf
ENV WRF_SRC_ROOT_DIR=${DIR}/WRF
ENV LIBS=${DIR}/LIBRARIES
ENV CC=icc
ENV CXX=icpc
ENV FC=ifort
ENV FCFLAGS=-m64
ENV F77=ifort
ENV FFLAGS=-m64
ENV JASPERLIB=$LIBS/grib2/lib
ENV JASPERINC=$LIBS/grib2/include
ENV LDFLAGS=-L$LIBS/grib2/lib
ENV CPPFLAGS=-I$LIBS/grib2/include





## Install Libraries
WORKDIR $LIBS

### zlib 1.2.7
RUN wget https://zlib.net/fossils/zlib-1.2.7.tar.gz && \
    tar -xzf zlib-1.2.7.tar.gz && \
    cd zlib-1.2.7 && \
    ./configure --prefix=$DIR/grib2 && \
    make && make install && cd ..

### libpng 1.2.50
RUN wget https://sourceforge.net/projects/libpng/files/libpng12/older-releases/1.2.50/libpng-1.2.50.tar.gz && \
    tar -xzf libpng-1.2.50.tar.gz && \
    cd libpng-1.2.50 && \
    ./configure --prefix=$DIR/grib2 && \
    make && make install && cd ..

# Jasper 1.900.1
RUN wget https://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip && \
    unzip jasper-1.900.1.zip && \
    cd jasper-1.900.1 && \
    ./configure --prefix=$DIR/grib2 && \
    make && make install && cd ..


## Install Dependencies
### NetCDF 4.6.2



### PNetCDF 1.11.0



### PHDF5 1.10.4




## Install WRF
WORKDIR $DIR

RUN wget https://github.com/wrf-model/WRF/archive/refs/tags/v4.2.2.tar.gz && \
    tar -zxf v4.2.2.tar.gz && \
    mv WRF-4.2.2/ WRF



#TODO: Fix TACC paths to container paths
#ENV PATH=${TACC_NETCDF_BIN}:${TACC_PNETCDF_BIN}:$PATH
#ENV NETCDF=${TACC_NETCDF_DIR}
#ENV PNETCDF=${TACC_PNETCDF_DIR}
#ENV PHDF5=${TACC_HDF5_DIR} 

ENV WRFIO_NCD_LARGE_FILE_SUPPORT=1
ENV WRF_EM_CORE=1
ENV KMP_STACKSIZE=512m

##ENV LDFLAGS="-lm -lnetcdff -lnetcdf -L${TACC_NETCDF_LIB}"
#ENV LDFLAGS="-lm -lnetcdff -lnetcdf -L${TACC_PNETCDF_LIB}"









## Install WPS?





## 

RUN ldconfig
 
