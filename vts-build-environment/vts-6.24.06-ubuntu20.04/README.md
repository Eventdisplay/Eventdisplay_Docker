# VERITAS 6.24.06-ubuntu20.04

**this is experimental and will not work for you...**

https://github.com/root-project/root-docker

## Building

Building expects the following tar packages in the build directory:
- VBF-0.3.4.tar.gz

```
$ docker build -t vts-6.24.06-ubuntu20.04 .
```

## Running

Run the image and provide a bash environment:

```
$ docker run --rm -it -v "$(pwd):/data" vts-6.24.06-ubuntu20.04 bash
```

## Testing

using `./docker_run.sh`

```
$ ./bin/evndisp -display=1 -sourcefile /CARE_June2020/gamma_V6_CARE_std_Atmosphere62_zen20deg_0.5wob_160MHz_1.vbf -sourcetype=2  -reconstructionparameter EVNDISP.reconstruction.runparameter.v4x
```
