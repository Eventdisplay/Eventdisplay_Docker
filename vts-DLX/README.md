# Eventdisplay VERITAS DL1 Docker file

## Building

Building expects that a tar ball of vbf (VBF-0.3.4.tar.gz) is available in the building directory.

```
$ docker build -t eventdisplay-vts-dl1 .
```

## Running

Run the image and provide a bash environment:

```
$ docker run --rm -it eventdisplay-vts-dl1 bash
```
