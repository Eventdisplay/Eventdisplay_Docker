# V2DL3 Docker file for ROOT-to-FITS conversion

Docker file used for development environment for V2DL3



## Building

```
$ docker build -t vts-v2dl3-dev .
```

Your GitHub user name and password is required, as the V2DL3 GitHub repository is a private repository.

## Running

Run the image and provide a bash environment:

```
%  docker run --rm -it -v "$(pwd)/data:/data" -v "$(pwd)/V2DL3:/v2dl3" vts-v2dl3-dev bash
```

Using the run script with an analysis example:
```
v2dl3 -f /data/64080.anasum.root /data/effArea-v485-auxv01-CARE_June2020-Cut-NTel2-PointSource-Moderate-TMVA-BDT-GEO-V6_2012_2013a-ATM62-T1234.root /data/tt.fits.gz
```

## Version v0.1.0

Dockerfile: Dockerfile-v0.1.0

```
docker build -t vts-v2dl3-dev-0.1.0 -f Dockerfile-v0.1.0 .
docker run --rm -it -v "$(pwd)/data:/data" -v "$(pwd)/V2DL3-0.1.0:/v2dl3" vts-v2dl3-dev-0.1.0 bash
cd /v2dl3
pip install .
```
