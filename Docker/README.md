# Docker Container for WRF 4.2.2
A public Docker container for WRF 4.2.2 with the Intel OneAPI HPC Toolkit.

<!-- Docker image: [Docker Hub](https://hub.docker.com/repository/docker/cornellcac/wrf)

Singularity image: -->

# Build
The Docker container can be built using the script [`docker-build.sh`](https://github.com/federatedcloud/WRFv4-Benchmarking/blob/main/Docker/docker-build.sh),
which will produce an output file named `build_output.txt` (included in the 
[`.gitignore`](https://github.com/federatedcloud/WRFv4-Benchmarking/blob/main/.gitignore)).
The build will take some time, so it is recommended to use a terminal multiplexer, such as `tmux`.
One can view the full output at any time using a text editor to open `build_output.txt`.
To determine what step the build it is at, one can do:

    cat build_output.txt | grep Step | tail -n 1

This will print the current command Docker is executing to build the container.
To view Docker build errors, try:

    cat build_output.txt | grep ERROR

This is actually the last command in the `docker-build.sh` script, so Docker build
errors will be listed upon completion.  If there are no errors listed the container
was built successfully.  Code and dependencies should be checked independently of
a Docker build error list.

## Compiling
(Currently under development)

WRF and WPS compilation is performed in bash.  Please see the [Dockerfile](https://github.com/federatedcloud/WRFv4-Benchmarking/blob/main/Docker/Dockerfile)
for full commands.

