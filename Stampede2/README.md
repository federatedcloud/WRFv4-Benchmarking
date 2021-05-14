# Building WRF 4.2.2 With Intel and Running on Stampede2

## Configure and Compile WRF 4.2.2 with Intel 18.0.2

### Before Compiling

#### Install Libraries

Script `install_libs.sh` in the LIBRARIES directory

#### Download WRF 4.2.2

We obtained the [WRF 4.2.2 release tarball](https://github.com/wrf-model/WRF/releases/tag/v4.2.2) from the official [WRF-ARW Modeling System](https://github.com/wrf-model/WRF) GitHub repository.

```
wget https://github.com/wrf-model/WRF/archive/refs/tags/v4.2.2.tar.gz
tar -zxvf v4.2.2.tar.gz
mv WRF-4.2.2/ WRF
```

For simplicity, we renamed the directory to `WRF`.


### Start Compile

Script to configure and compile is `config_compile_18.sh`...


## CONUS 12km Benchmark
### Setup Run

### Submit Job

### Results Comparison


## CONUS 2.5km Benchmark
### Setup Run

### Submit Job

### Results Comparison
 

