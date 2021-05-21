# Eventdisplay VERITAS Docker file for development

## Building

Building expects that a tar ball of vbf (VBF-0.3.4.tar.gz) is available in the building directory.

This version depends on the some private VERITAS repositories, therefor the build command is:

Expect that the Eventdisplay code is installed into the data directory.

```
$ docker build -t vts-dlx-dev .
```

## Running

Run the image and provide a bash environment:

```
$ docker run --rm -it -v "$(pwd)/data:/data" vts-dlx-dev bash
```

