# drbd-docker

This container builds and inserts the DRBD module into the host kernel.

## Requirements

Unfortunately, due to DRBD's kernel module, this image only run
on kernels where Ubuntu Bionic, the OS for the base image, can pull
down kernel headers (such as k3os).

## Image

An up-to date Docker image can be found on Dockerhub at
`jmcswain/drbd-docker`. To pull:

```bash
docker pull jmcswain/drbd-docker
```

## Usage

### Kernel Modules

A custom kernel module is installed when the container boots up. In
order for this process to work, the underlying system either already
needs to have DRBD installed or the host modules directory needs
to be shared with the container. Specifically, the `/lib/modules`
directory needs to be mapped to `/lib/modules` in the container. This
can be done with the `-v /lib/modules:/lib/modules` flag in `docker
run`.

### Within Kubernetes

The `kubernetes/` subdirectory gives an example of this image as an
`initContainer` for a `linstor-satellite` DaemonSet.

#### Notes on k3os

K3os uses Ubuntu's mainline kernel for packaging, and recent releases
provide the kernel headers (in /usr/src/), meaning the only real
requirement would be DKMS and the DRBD module source, but the scope of
this image is more generic than k3os.

I will personally be deploying and using this image on bleeding edge k3os releases.

### Permissions

When running a container based upon this image, the following system
capabilities are necessary:

- SYS_MODULE

### Example `docker run` command

```bash
docker run -it --rm --cap-add sys_module \
       -v /lib/modules:/lib/modules \
       jmcswain/drbd-docker
```
