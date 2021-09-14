# Docker Container for WRF 4.2.2
A Docker container for WRF 4.2.2 with the Intel OneAPI HPC Toolkit.

## Docker Image Info
The Docker image is available on [DockerHub](https://hub.docker.com/repository/docker/cornellcac/wrf) as cornellcac/wrf:4.2.2.  Pull with
```
docker pull docker pull cornellcac/wrf:4.2.2
```

The image is ~24.6GB, so prepare for a reasonably-sized disk to pull and work with it, as well as time to let it download.
This Docker container follows [Singularity's Best Practices for Dockerfiles](https://sylabs.io/guides/3.5/user-guide/singularity_and_docker.html#best-practices), rather than [Docker Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/), because it was designed to be converted to Singularity.  Therefore, it should not be used in an insecure location (i.e. public cloud with a loose security group/firewall) since it is using the root user only.
Additionally, it should not be used to attempt anything involving multi-VM MPI just yet.  The Docker container will need to have some additions before this.

## Build
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

This is included in the `docker-build.sh` script, so Docker build
errors will be listed upon completion.  If there are no errors listed, the container
was likely built successfully, but be sure to check the output.  Code and dependencies
should be checked independently of a Docker build error list.

## Compile

WRF compilation is performed in bash with Intel compilers and Intel MPI libraries during the container build.
Please see the [Dockerfile](https://github.com/federatedcloud/WRFv4-Benchmarking/blob/main/Docker/Dockerfile)
for full commands.

More details soon.

