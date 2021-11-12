# Introduction

[![DOI](https://zenodo.org/badge/278472802.svg)](https://zenodo.org/badge/latestdoi/278472802)

Docker files for different Eventdisplay applications - mostly for CTA and VERITAS. 

Install [Docker](https://www.docker.com/community-edition#/download) to run these images.

# Dockerfiles

Docker files are available for the following applications:

- [CTA Sensitivity plotting](./cta-slib) - image from docker hub: [gernotmaier/eventdisplay-cta-slib](https://hub.docker.com/repository/docker/gernotmaier/eventdisplay-cta-slib)
- [CTA DL1 Analysis (prod5)](./cta-DL1-prod5) - image from docker hub: [gernotmaier/eventdisplay-cta-dl1-prod5](https://hub.docker.com/r/gernotmaier/eventdisplay-cta-dl1-prod5)
- [CTA DL1 prod3b-SCT Analysis](./cta-DL1-prod3b-SCT) - image from docker hub: [gernotmaier/eventdisplay-cta-dl1-prod3b-sct](https://hub.docker.com/r/gernotmaier/eventdisplay-cta-dl1-prod3b-sct)
- [CTA DL1 prod3b-SCT-Alpha Analysis](./cta-DL1-prod3b-SCT-merge) - image from docker hub: [gernotmaier/eventdisplay-cta-dl1-prod3b-sct-merge](https://hub.docker.com/repository/docker/gernotmaier/eventdisplay-cta-dl1-prod3b-sct-merge) 
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

Using directly the docker image:
```
singularity shell docker://gernotmaier/eventdisplay-cta-slib:v03
```
(remember possibly to set singularity cache to a different directory using $SINGULARITY_CACHEDIR

# Container and CTA

See [redmine](https://forge.in2p3.fr/projects/cta_dirac/wiki/Notes_on_containers) for discussion of usage of containers in CTA.


