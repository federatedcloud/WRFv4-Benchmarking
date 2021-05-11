#!/bin/bash
# Script to run configure and compile with Intel 18 on Stampede2

export WRF_SRC_ROOT_DIR=$WORK2/WRF_Benchmarking/WRFv4-Benchmarking/Stampede2/WRF
cd $WRF_SRC_ROOT_DIR

# Fresh config
./clean -a

# Load system modules
module reset # Should include intel/18.0.2 impi/18.0.2
module load netcdf/4.6.2 pnetcdf/1.11.0 phdf5/1.10.4

export LIBS=${WRF_SRC_ROOT_DIR}/../LIBRARIES
export CC=icc
export CXX=icpc
export FC=ifort
export FCFLAGS=-m64
export F77=ifort
export FFLAGS=-m64
export JASPERLIB=$LIBS/grib2/lib
export JASPERINC=$LIBS/grib2/include
export LDFLAGS=-L$LIBS/grib2/lib
export CPPFLAGS=-I$LIBS/grib2/include

export PATH=${TACC_NETCDF_BIN}:${TACC_PNETCDF_BIN}:$PATH
export NETCDF=${TACC_NETCDF_DIR}
export PNETCDF=${TACC_PNETCDF_DIR}
export PHDF5=${TACC_HDF5_DIR} 

export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export WRF_EM_CORE=1
export KMP_STACKSIZE=512m

#export LDFLAGS="-lm -lnetcdff -lnetcdf -L${TACC_NETCDF_LIB}"
export LDFLAGS="-lm -lnetcdff -lnetcdf -L${TACC_PNETCDF_LIB}"

# input 21 (icc/ifort) and 1 (basic nesting) to configure script
echo '20\n1\n' | ./configure

# modifications for Intel 
sed -i -e 's/gcc/icc/' ./configure.wrf

## Libs and includes modified in configure.wrf needed for Stampede2
#export var=" -DNETCDF -DPNETCDF -I${WRF_SRC_ROOT_DIR}/external/io_netcdf -I${NETCDF}/include -L${WRF_SRC_ROOT_DIR}/external/io_netcdf -lwrfio_nf -L${TACC_NETCDF_LIB} -lnetcdff -lnetcdf -I${WRF_SRC_ROOT_DIR}/external/io_pnetcdf -I${PNETCDF}/include -L${WRF_SRC_ROOT_DIR}/external/io_pnetcdf -lwrfio_pnf -L${TACC_PNETCDF_LIB} -lpnetcdf"
#awk -v mytext="${var}" '/^NETCDF4_DEP_LIB / {$0=$0mytext} 1' configure.wrf > temp && mv temp configure.wrf

awk -v add=" -L${LIBS}/zlib-1.2.7" '/^ZLIB/ {$0=$0add} 1' configure.wrf > temp && mv temp configure.wrf
#awk -v add=" -L${TACC_HDF5_DIR}/lib -lhdf5_fortran -lhdf5" '/^HDF5/ {$0=$0add} 1' configure.wrf > temp && mv temp configure.wrf
#awk -v add="                      -I${WRF_SRC_ROOT_DIR}/external/io_pnetcdf \\" 'NR==200 {print add} {print}' configure.wrf > temp && mv temp configure.wrf
#awk -v add="                      -I${PNETCDF}/include \\" 'NR==201 {print add} {print}' configure.wrf > temp && mv temp configure.wrf
#awk -v add="                      -I${WRF_SRC_ROOT_DIR}/dyn_nmm \\" 'NR==202 {print add} {print}' configure.wrf > temp && mv temp configure.wrf
#awk -v add="                      -I${WRF_SRC_ROOT_DIR}/dyn_em \\" 'NR==203 {print add} {print}' configure.wrf > temp && mv temp configure.wrf
#awk -v add="                      -I${WRF_SRC_ROOT_DIR}/main \\" 'NR==204 {print add} {print}' configure.wrf > temp && mv temp configure.wrf

#export MODULEPATH=${WRF_SRC_ROOT_DIR}/dyn_nmm:${WRF_SRC_ROOT_DIR}/dyn_em:${WRF_SRC_ROOT_DIR}/main:$MODULEPATH
#echo "MODULEPATH = ${MODULEPATH}"

# Compile
#time ./compile -j 2 em_real >& compile_em_real.log
time ./compile em_real >& compile_em_real.log

#TESTING serial compile to determine which error occurs first
#time ./compile -j 1 em_real >& compile_em_real.log

