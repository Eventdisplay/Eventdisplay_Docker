# Eventdisplay VERITAS DL3 Docker file

Docker file to convert VERITAS eventdisplay to DL3

Note that this Dockerfile (still) depends on Eventdisplay v4x and requires access to private VERITAS repositories

## Building

Building expects that a tar ball of vbf (VBF-0.3.4.tar.gz) is available in the building directory.

```
$ docker build -t eventdisplay-vts-v2dl3 .
```

## Running

Run the image and provide a bash environment:

```
$ docker run --rm -it eventdisplay-vts-v2dl3 bash
```
