# WRFv4-Benchmarking
Implementations of WRF 4.2.2 to run CONUS benchmarks on bare metal HPC, in a Docker container, and a Singularity container.

## Data
The [data](https://www2.mmm.ucar.edu/wrf/users/benchmark/benchdata_v422.html) used for the CONUS benchmarks was made publicly available by NCAR.  Please see the link for more information.
> Input data used was [GFS 0.25 degree analysis](https://rda.ucar.edu/datasets/ds084.1/).
>
> The case is the [Pre-Thanksgiving Winter Storm of 2019](https://weather.com/storms/winter/news/2019-11-24-snowstorm-rockies-denver-plains-midwest-thanksgiving-week).

### Benchmarks
* [CONUS 12-km](https://www2.mmm.ucar.edu/wrf/users/benchmark/v4_bench_conus12km.tar.gz)
* [CONUS 2.5-km](https://www2.mmm.ucar.edu/wrf/users/benchmark/v4_bench_conus2.5km.tar.gz)

## Bare Metal HPC
WRF 4.2.2 was compiled on TACC's Stampede2 supercomputer with the Intel 18.0.2 compiler for use on the Intel Skylake nodes.  For full instructions on how to compile, set up, and run the benchmarks on bare metal HPC, please see the [Stampede2 README](https://github.com/federatedcloud/WRFv4-Benchmarking/tree/main/Stampede2#building-wrf-422-with-intel-and-running-on-stampede2).


## Docker Container
Currently in development.

## Singularity Container
Currently in development.
