# Eventdisplay CTA DL1 Docker file - prod3b SCT analysis

## Building

Building expects that a tar ball of hessioxx (hessioxxx.tar.gz) is available in the building directory.

```
$ docker build -t eventdisplay-cta-dl1-prod3b-sct .
```

Download hessioxx from https://www.mpi-hd.mpg.de/hfm/CTA/MC/Software/Testing/hessioxxx.tar.gz (passwd applies)

## Running

Sim_telarray files and output evndisp root files are read and writting from the ./data directory.

To analysis a prod3b sim_telarray file:

```
$  docker run --rm -it -v "$(pwd)/data:/data" eventdisplay-cta-dl1-prod3b-sct \
     /evndisp/run.sh \
     /data/gamma_20deg_0deg_run100___cta-prod3-sct_desert-2150m-Paranal-SCT.simtel.gz
```

To run the container in bash and analyse a prod5 sim_telarray file:

```
$ docker run --rm -it -v "$(pwd)/data:/data" eventdisplay-cta-dl1-prod3b-sct bash
$ run.sh \
    /data/gamma_20deg_0deg_run100___cta-prod3-sct_desert-2150m-Paranal-SCT.simtel.gz
```
