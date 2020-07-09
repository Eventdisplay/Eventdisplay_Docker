# Eventdisplay CTA DL1 Docker file

## Building

Building expects that a tar ball of hessioxx (hessioxxx.tar.gz) is available in the building directory.

```
$ docker build -t eventdisplay-cta-dl1 .
```

## Running

To run the container:

```
$ docker run --rm -it -v "$(pwd)/data:/data" eventdisplay-cta-dl1 bash
```
