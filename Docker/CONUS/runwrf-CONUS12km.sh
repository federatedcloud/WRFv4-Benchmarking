#!/bin/bash
## Removes previous logs and runs WRF.

cd $WRF_SRC_ROOT_DIR/run
rm rsl.*

time mpirun -np 14 ./wrf.exe
