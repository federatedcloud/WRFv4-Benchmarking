FROM intel/oneapi-hpckit@sha256:7415915e0b8eede7bba8b39aa9261ee08f3c57382b225d5240086c5c512afcbc
#FROM intel/oneapi-hpckit:devel-ubuntu18.04

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
    m4 \
    rsync

RUN mkdir /opt/wrf
RUN set -eux

## Set up some useful environment variables
ENV MAIN_DIR=/opt/wrf
ENV WRF_SRC_ROOT_DIR=${MAIN_DIR}/WRF
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
ENV NETCDF=$DIR/NETCDF
ENV PNETCDF=$DIR/PNETCDF
ENV PHDF5=$DIR/PHDF5
ENV LDFLAGS=-L$DIR/grib2/lib
ENV CPPFLAGS="-I${PHDF5}/include -I${PNETCDF}/include -I${NETCDF}/include -I$DIR/grib2/include"
ENV PATH=${NETCDF}/bin:${PNETCDF}/bin:$PATH:$DIR/grib2
ENV LD_LIBRARY_PATH=$PHDF5/lib:$PNETCDF/lib:$NETCDF/lib:$LD_LIBRARY_PATH:$DIR/grib2/lib
ENV WRFIO_NCD_LARGE_FILE_SUPPORT=1
ENV WRF_EM_CORE=1
ENV KMP_STACKSIZE=512m

## Set environment for interactive container shells
RUN echo export WRF_SRC_ROOT_DIR=${DIR}/WRF >> /etc/bashrc && \
    echo export DIR=${MAIN_DIR}/LIBRARIES >> /etc/bashrc && \
    echo export I_MPI_CC=icc >> /etc/bashrc && \
    echo export I_MPI_CXX=icpc >> /etc/bashrc && \
    echo export I_MPI_F77=ifort >> /etc/bashrc && \
    echo export I_MPI_F90=ifort >> /etc/bashrc && \
    echo export CC=mpicc >> /etc/bashrc && \
    echo export CXX=icpc >> /etc/bashrc && \
    echo export FC=mpif90 >> /etc/bashrc && \
    echo export F77=mpif90 >> /etc/bashrc && \
    echo export FFLAGS=-m64 >> /etc/bashrc && \
    echo export JASPERINC=$DIR/grib2/include >> /etc/bashrc && \
    echo export JASPERLIB=$DIR/grib2/lib >> /etc/bashrc && \
    echo export NETCDF=$DIR/NETCDF >> /etc/bashrc && \
    echo export PNETCDF=$DIR/PNETCDF >> /etc/bashrc && \
    echo export PHDF5=$DIR/PHDF5 >> /etc/bashrc && \
    echo export LDFLAGS=-L$DIR/grib2/lib >> /etc/bashrc && \
    echo export CPPFLAGS="-I${PHDF5}/include -I${PNETCDF}/include -I${NETCDF}/include -I$DIR/grib2/include" >> /etc/bashrc && \
    echo export PATH=$PATH:$DIR/grib2 >> /etc/bashrc && \
    echo export LD_LIBRARY_PATH=$PHDF5/lib:$PNETCDF/lib:$NETCDF/lib:$LD_LIBRARY_PATH:$DIR/grib2/lib >> /etc/bashrc && \
    echo export WRFIO_NCD_LARGE_FILE_SUPPORT=1 >> /etc/bashrc && \
    echo export WRF_EM_CORE=1 >> /etc/bashrc && \
    echo export KMP_STACKSIZE=512m >> /etc/bashrc

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
### PHDF5 1.10.4
RUN wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.4/src/hdf5-1.10.4.tar.gz && \
    tar -xzf hdf5-1.10.4.tar.gz && \
    cd hdf5-1.10.4 && \
    ./configure --enable-fortran --enable-parallel --enable-shared --with-zlib=$DIR/grib2 --prefix=$PHDF5 && \
    make && make install && cd ..

### PNetCDF 1.11.0
ENV LDFLAGS="-L$PHDF5/lib -L$DIR/grib2/lib"
RUN echo export LDFLAGS="-L$PHDF5/lib -L$DIR/grib2/lib" >> /etc/bashrc

RUN wget http://cucis.ece.northwestern.edu/projects/PnetCDF/Release/pnetcdf-1.11.0.tar.gz && \
    tar -xzf pnetcdf-1.11.0.tar.gz && \
    cd pnetcdf-1.11.0 && \ 
    ./configure --prefix=$PNETCDF --enable-fortran --enable-shared  && \
    make install

### NetCDF-C 4.6.2
ENV LDFLAGS="-L$PNETCDF/lib -L$PHDF5/lib -L$DIR/grib2/lib"
RUN echo export LDFLAGS="-L$PNETCDF/lib -L$PHDF5/lib -L$DIR/grib2/lib" >> /etc/bashrc

RUN mkdir -p ${NETCDF} && \
    cd ${NETCDF} && \
    wget https://github.com/Unidata/netcdf-c/archive/v4.6.2.tar.gz && \
    tar -xzf v4.6.2.tar.gz && \
    cd netcdf-c-4.6.2 && \
    ./configure --enable-fortran --enable-netcdf-4 --disable-static --disable-dap --enable-shared --with-pic --enable-parallel-tests -enable-pnetcdf --enable-largefile --prefix=${NETCDF} && \
    make && make install

### NetCDF-Fortran 4.5.3
ENV LDFLAGS="-L$NETCDF/lib -L$PNETCDF/lib -L$PHDF5/lib -L$DIR/grib2/lib"
ENV LD_LIBRARY_PATH=${NETCDF}/lib:${LD_LIBRARY_PATH}
RUN echo export LDFLAGS="-L$NETCDF/lib -L$PNETCDF/lib -L$PHDF5/lib -L$DIR/grib2/lib" >> /etc/bashrc && \
    echo export LD_LIBRARY_PATH=${NETCDF}/lib:${LD_LIBRARY_PATH} >> /etc/bashrc

RUN cd ${NETCDF} && \
#    wget https://github.com/Unidata/netcdf-fortran/archive/v4.4.5.tar.gz && \
#    tar -xzf v4.4.5.tar.gz && \
    wget https://github.com/Unidata/netcdf-fortran/archive/refs/tags/v4.5.2.tar.gz && \
    tar -xzf v4.5.2.tar.gz && \
    cd netcdf-fortran-4.5.2 && \
    ./configure  --disable-static --enable-shared --with-pic --enable-parallel-tests --prefix=${NETCDF} && \
    make && make install

ENV NETCDF4=1
RUN echo export export NETCDF4=1 >> /etc/bashrc

## Install WRF 4.2.2
WORKDIR $MAIN_DIR

ENV LDFLAGS="-lm -lnetcdf -lnetcdff -L${PNETCDF}/lib"
RUN echo export LDFLAGS="-lm -lnetcdff -L${PNETCDF}/lib" >> /etc/bashrc

### Get WRF v4.2.2 tar archive
RUN wget https://github.com/wrf-model/WRF/archive/refs/tags/v4.2.2.tar.gz && \
    tar -zxf v4.2.2.tar.gz && \
    mv WRF-4.2.2/ WRF

WORKDIR $WRF_SRC_ROOT_DIR

### Configure WRF
RUN ./clean -a && \
    echo '66\n1\n' | ./configure && \
    sed -i -e 's/gcc/icc/' ./configure.wrf && \
    awk -v add=" -L${DIR}/zlib-1.2.7" '/^ZLIB/ {$0=$0add} 1' configure.wrf > temp && mv temp configure.wrf

### Compile WRF
RUN time ./compile em_real 2>&1 | tee compile_em_real.log


#TODO: Add a check that WRF installed correctly, error otherwise
#TODO: Install WPS?

## For development
#TODO: Comment these out for production
RUN apt install -y \
    man \
    bash-completion \
    vim \ 
    htop \
    tmux 


RUN ldconfig
 
