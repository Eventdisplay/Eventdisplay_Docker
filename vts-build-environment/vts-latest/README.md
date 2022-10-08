# VERITAS ROOT-latest

https://github.com/root-project/root-docker

## Building

Building expects the following tar packages in the build directory:
- VBF-0.3.4.tar.gz

```
$ docker build -t vts-latest .
```
or
```
docker build  -t vts-latest --build-arg "EVNDISPVERSION=490-dev-v0.7" .
```

## Running

Run the image and provide a bash environment:

```
$ docker run --rm -it -v "$(pwd):/data" vts-latest bash
```

