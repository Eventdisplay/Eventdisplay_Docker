# VERITAS vts-6.22.08-fedora34

https://github.com/root-project/root-docker

## Building

Building expects the following tar packages in the build directory:
- VBF-0.3.4.tar.gz

```
$ docker build -t vts-6.22.08-fedora34 .
```

## Running

Run the image and provide a bash environment:

```
$ docker run --rm -it -v "$(pwd):/workdir" vts-6.22.08-fedora34 bash
```

