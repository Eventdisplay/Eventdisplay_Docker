# Eventdisplay VERITAS DL1 Docker file

Docker file for analysis VERITAS rawdata (vbf) and prepare a DL1 file.

## Building

Building expects that a tar ball of vbf (VBF-0.3.4.tar.gz) is available in the building directory.

This version depends on the some private VERITAS repositories, therefor the build command is:

```
$ docker build --build-arg GITUSER="my-git-username" --build-arg GITPW="my-gitpassword" -t eventdisplay-vts-dl1 .
```

## Running

Run the image and provide a bash environment:

```
$ docker run --rm -it eventdisplay-vts-dl1 bash
```

## Using X11 for displaying

(steps for Mac OSX; fillowing the description on the [root docker webpage](https://github.com/root-project/root-docker)

1. go to XQuartz, Preferences, select the Security tab, and tick the box "Allow connections from network clients" 
2. get ip: `ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')`
3. start XQuartz whitelisting your ip: `xhost + $ip`
4. start root
docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$ip:0 eventdisplay-vts-dl1 bash
