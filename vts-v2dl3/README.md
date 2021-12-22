# V2DL3 Docker file for ROOT-to-FITS conversion

Docker file to convert VERITAS Eventdisplay anasum files to DL3 FITS using the V2DL3 converter. 

Note that V2DL3 is unfortunately private software.

## Building

```
$ docker build --build-arg GITUSER="my-git-username" --build-arg GITPW="my-gitpassword" -t vts-v2dl3 .
```

Your GitHub user name and password is required, as the V2DL3 GitHub repository is a private repository.

## Running

Run the image and provide a bash environment:

```
$ docker run --rm -it vts-v2dl3 bash
```

Using the run script with an analysis example:
```
v2dl3 -f /data/64080.anasum.root /data/effArea-v485-auxv01-CARE_June2020-Cut-NTel2-PointSource-Moderate-TMVA-BDT-GEO-V6_2012_2013a-ATM62-T1234.root /data/tt.fits.gz
```

## Docker hub

e.g.:
```
docker tag 526b6f7d5de8 gernotmaier/vts-v2dl3:v02
docker push gernotmaier/vts-v2dl3:v02
```

## Singularity

Build a singularity image, as required for many HEP computing environments.

1. Save docker image
```
docker save 488f4c543443 -o vts-v2dl3.tar
```
(find the Image ID using `docker images`)

2. Convert Docker image to Singularity
```
singularity build --sandbox sing_from_tar vts-v2dl3.tar
```

```
singularity build --sandbox vts-v2dl3.sif docker://gernotmaier/vts-v2dl3:v02
```
