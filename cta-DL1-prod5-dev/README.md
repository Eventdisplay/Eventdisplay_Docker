# Eventdisplay CTA DL1 Docker file (development)

This is a development version for analysing CTA DL1 files (including valgrind and other tools)

## Building

Building expects 

- a tar ball of hessioxx (hessioxxx.tar.gz) is available in the building directory.
- evndisp code installed into data/code
- eventdisplay analysis files installed into data/Eventdisplay_AnalysisFiles_CTA


```
$ docker build -t eventdisplay-cta-dl1-prod5-dev .
```
(for rebuilt with `--no-cache`)

Download hessioxx from https://www.mpi-hd.mpg.de/hfm/CTA/MC/Software/Testing/hessioxxx.tar.gz (passwd applies)

## Running

Sim_telarray files and output evndisp root files are read and writting from the ./data directory.

To analysis a prod5 sim_telarray file:

```
$  docker run --rm -it -v "$(pwd)/data:/data" eventdisplay-cta-dl1-prod5-dev \
     /evndisp/run.sh \
     /data/gamma_20deg_0deg_run9___cta-prod5-paranal_desert-2147m-Paranal-dark_cone10.simtel.zst \
     CTA.prod5S.BL-4LSTs25MSTs70SSTs-MSTF.lis
```

To run the container in bash and analyse a prod5 sim_telarray file:

```
$ docker run --rm -it -v "$(pwd)/data:/data" eventdisplay-cta-dl1-prod5-dev bash
$ run.sh \
    /data/gamma_20deg_0deg_run9___cta-prod5-paranal_desert-2147m-Paranal-dark_cone10.simtel.zst \
    CTA.prod5S.BL-4LSTs25MSTs70SSTs-MSTF.lis
```

