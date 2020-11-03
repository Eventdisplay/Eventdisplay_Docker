# Introduction

Experimental Docker files (and later images) are provided for different Eventdisplay applications. You must [have Docker installed](https://www.docker.com/community-edition#/download) to run these images.

# Dockerfiles

The following Docker files are available:

- [CTA DL1 Analysis (prod5)](./cta-DL1-prod5)
- [CTA DL1 Analysis (prod3b-SCT)](./cta-DL1-prod3b-SCT)
- [VERITAS DLX Analysis](./vts-DLX)


# Docker and Singularity

Build a singularity image using docker hub:
```
singularity build --sandbox eventdisplay-cta-dl1-prod3b-sct_v01.sif  docker://gernotmaier/eventdisplay-cta-dl1-prod3b-sct:v01
```

Build a singular image from a tar file:

find the docker image locally:
```
docker images

REPOSITORY                                    TAG                 IMAGE ID            CREATED             SIZE
eventdisplay-cta-dl1-prod3b-sct               latest              488f4c543443        22 hours ago        1.12GB
gernotmaier/eventdisplay-cta-dl1-prod3b-sct   v01                 488f4c543443        22 hours ago        1.12GB
```

export docker image to tar file:
```
docker save 488f4c543443 -oo eventdisplay-cta-dl1-prod3b-sct.tar
```

Import docker image to singularity:
```
singularity build --sandbox sing_from_tar eventdisplay-cta-dl1-prod3b-sct.tar
```

For a discussion on how to convert a Dockerfile into sinularity recipies, see [here](https://singularityhub.github.io/singularity-cli/recipes)

Running singularity:
```
singularity exec -e --bind $(PWD)/sing_data:/data eventdisplay-cta-dl1-prod3b-sct_v01.sif /evndisp/run.sh gamma_20deg_0deg_run100___cta-prod3-sct_desert-2150m-Paranal-SCT.simtel.gz
```



