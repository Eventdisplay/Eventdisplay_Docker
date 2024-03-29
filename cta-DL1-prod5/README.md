# Eventdisplay CTA DL1 Docker file

## Building

Building expects that a tar ball of hessioxx (hessioxxx.tar.gz) is available in the building directory.

```
$ docker build -t eventdisplay-cta-dl1-prod5 .
```
(for rebuilt with `--no-cache`)

Download hessioxx from https://www.mpi-hd.mpg.de/hfm/CTA/MC/Software/Testing/hessioxxx.tar.gz (passwd applies)

## Running

Sim_telarray files and output evndisp root files are read and writting from the ./data directory.

To analysis a prod5 sim_telarray file:

```
$  docker run --rm -it -v "$(pwd)/data:/data" eventdisplay-cta-dl1-prod5 \
     /workdir/run.sh \
     /data/gamma_20deg_0deg_run9___cta-prod5-paranal_desert-2147m-Paranal-dark_cone10.simtel.zst \
     CTA.prod5S.BL-4LSTs25MSTs70SSTs-MSTF.lis
```

To run the container in bash and analyse a prod5 sim_telarray file:

```
$ docker run --rm -it -v "$(pwd)/data:/data" eventdisplay-cta-dl1-prod5 bash
$ run.sh \
    /data/gamma_20deg_0deg_run9___cta-prod5-paranal_desert-2147m-Paranal-dark_cone10.simtel.zst \
    CTA.prod5S.BL-4LSTs25MSTs70SSTs-MSTF.lis
```

## Containers

Containers to be used for prod5 analysis are available throught dockerhub: 

https://hub.docker.com/r/gernotmaier/eventdisplay-cta-dl1-prod5

```
docker pull gernotmaier/eventdisplay-cta-dl1-prod5
```

## Using singularity

see [main README.md](../README.md)
