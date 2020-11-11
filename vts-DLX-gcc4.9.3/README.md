# Eventdisplay VERITAS DL1 Docker file with gcc 4.9.3

**this Dockerfile is not working**

Docker file for analysis VERITAS rawdata (vbf) and prepare a DL1 file with gcc 4.9.3

## Building

Building expects that a tar balls are available in the building directory for:
- VBF-0.3.4.tar.gz
- [root_v5.34.26.Linux-slc6_amd64-gcc4.9.tar.gz](https://root.cern/download/root_v5.34.26.Linux-slc6_amd64-gcc4.9.tar.gz)

(download not possible due to old certificates)

```
$ docker build -t eventdisplay-vts-dlx-gcc493 .
```

Building fails while compiling Eventdisplay.

## Running

Run the image and provide a bash environment:

```
$ docker run --rm -it eventdisplay-vts-dlx-gcc493 bash
```
