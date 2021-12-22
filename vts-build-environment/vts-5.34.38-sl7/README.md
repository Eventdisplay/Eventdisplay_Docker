# VERITAS SL7 Environment

SL7 environment including ROOT and VBF

see https://github.com/scientificlinux/sl-docker

## Building

Building expects the following tar packages in the build directory:
- VBF-0.3.4.tar.gz
- root_v5.34.38.source.tar.gz 

```
$ docker build -t vts-sl7-root-5.34.36 .
```

## Running

Run the image and provide a bash environment:

```
$ docker run --rm -it -v "$(pwd):/workdir" vts-sl7-root-5.34.36 bash
```

