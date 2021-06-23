# Scripts for running CONUS Benchmarks with WRF 4.2.2 in Docker

Files are organized somewhat differently in the `cornellcac/wrf:4.2.2` container than in Stampede2, so these scripts have been slightly modified to point to the proper locations and run the appropriate commands.

The included scripts are not currently built into the Docker container, but can be added in with
```bash
docker cp CONUS <CONTAINER_NAME>:<LOCATION>
```
It is recommended to copy to `/opt/wrf`, but not required.

The files included are:
 - `install-CONUS12km.sh` installs, downloads, and decompresses the CONUS12km tarball. Then, itcalls `make_CONUS12km_links.sh` and copies `CONUS12km-namelist.input` to the working WRF directory.
 - `make_CONUS12km_links.sh` links the files in `CONUS12km_files` to the working WRF directory
 - `CONUS12km_files` contains the list of files from the CONUS12km benchmarks tarball to be copied into the working WRF directory
 - `CONUS12km-namelist.input` is an edited version of the default `namelist.input` file that comes in th CONUS12 archive that fixes some errors.
 - `runwrf-CONUS12km.sh` cleans any logs from previous runs then calls WRF.
