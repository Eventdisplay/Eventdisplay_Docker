# Eventdisplay CTA DL1 Docker file - prod3b Alpha + SCT analysis

This Docker file and run script prepare the following workflow:

1. extraction of CTA South Alpha configuration (approximation) from a prod3b file
2. merging with CTA SCT prod3b telescope (41 telescopes)
3. DL1 Eventdisplay analysis

The list of telescopes to be extracted in step 1 is given in [CTA.prod3bS-M6C5a-14MSTs40SSTs-MSTF.lis](CTA.prod3bS-M6C5a-14MSTs40SSTs-MSTF.lis)

Ready images can be pulled from docker hub with
```
docker pull gernotmaier/eventdisplay-cta-dl1-prod3b-sct-merge:v02
```


## Building

Building expects that a tar ball of hessioxx (hessioxxx.tar.gz) is available in the building directory.

```
$ docker build -t cta-dl1-prod3b-sct-merge .
```

Download hessioxx from https://www.mpi-hd.mpg.de/hfm/CTA/MC/Software/Testing/hessioxxx.tar.gz (passwd applies)

## Running

Sim_telarray files and output evndisp root files are read from and written to the ./data directory, which is linked to the container.

To extract, merge, and analyse, run for example:

```
$  mkdir -p ./data && docker run --rm -it -v "$(pwd)/data:/data" cta-dl1-prod3b-sct-merge \
     /workdir/run.sh \
     /data/gamma_20deg_0deg_run3227___cta-prod3_desert-2150m-Paranal-merged.simtel.gz \
     /data/gamma_20deg_0deg_run3227___cta-prod3-sct_desert-2150m-Paranal-SCT.simtel.gz
```

To run the container in bash, and execute the run script in the container:

```
$  mkdir -p ./data && docker run --rm -it -v "$(pwd)/data:/data" cta-dl1-prod3b-sct-merge bash
$ ./run.sh \
    /data/gamma_20deg_0deg_run3227___cta-prod3_desert-2150m-Paranal-merged.simtel.gz \
    /data/gamma_20deg_0deg_run3227___cta-prod3-sct_desert-2150m-Paranal-SCT.simtel.gz
```
