# V2DL3 Docker file for ROOT-to-FITS conversion

Docker file to convert VERITAS Eventdisplay anasum files to DL3 FITS using the V2DL3 converter. 

Note that V2DL3 is unfortunately private software.

## Building

```
$ docker build --build-arg GITHUBTOKEN="my-git-token" -t vts-v2dl3 .
```

Your GitHub user name and password is required, as the V2DL3 GitHub repository is a private repository.

## Running

Run the image and provide a bash environment:

```
$ docker run --rm -it -v "$(pwd)/data:/data" vts-v2dl3 bash
```

Using the run script with an analysis example:
```
v2dl3 -f /data/64080.anasum.root /data/effArea-v485-auxv01-CARE_June2020-Cut-NTel2-PointSource-Moderate-TMVA-BDT-GEO-V6_2012_2013a-ATM62-T1234.root /data/tt.fits.gz
```

To convert directly, do:
```
docker run --rm -it -v "$(pwd)/data:/data" vts-v2dl3 /workdir/run.sh \
                                                     64080.anasum.root \
                                                     effArea-v485-auxv01-CARE_June2020-Cut-NTel2-PointSource-Moderate-TMVA-BDT-GEO-V6_2012_2013a-ATM62-T1234.root
```

## Docker hub

e.g.:
```
docker tag 396165de13d9 gernotmaier/vts-v2dl3:v03
docker push gernotmaier/vts-v2dl3:v03

```

## Singularity

Build a singularity image, as required for many HEP computing environments.

1. Upload to docker hub (see previous sections

2. Convert Docker image to Singularity
```
export SINGULARITY_TMPDIR=$(pwd)
export SINGULARITY_CACHEDIR=$(pwd)
singularity build --sandbox vts-v2dl3.sif docker://gernotmaier/vts-v2dl3:v03
```
`SINGULARITY_TMPDIR` and `SINGULARITY_CACHEDIR` are default your home directory, which might not have enough disk space

alternative (produces a single sif file):
```
singularity pull docker://gernotmaier/vts-v2dl3:v03
```

3. Test the singularity container
```
singularity exec -e --bind $(PWD)/data:/data vts-v2dl3.sif \
                                             /workdir/run.sh \
                                             64080.anasum.root \
                                             effArea-v485-auxv01-CARE_June2020-Cut-NTel2-PointSource-Moderate-TMVA-BDT-GEO-V6_2012_2013a-ATM62-T1234.root
```
