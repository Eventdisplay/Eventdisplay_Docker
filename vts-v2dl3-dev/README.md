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
docker run --rm -it -v "$(pwd)/data_v486:/data" -v "$(pwd)/V2DL3-0.1.0:/v2dl3" vts-v2dl3-dev-0.1.0 bash
cd /v2dl3
pip install .
```

## Master

```
docker run --rm -it -v "$(pwd)/data_v486_master:/data" -v "$(pwd)/V2DL3-master:/v2dl3" vts-v2dl3-dev-0.1.0 bash
```

## Development

Building:
```
docker build -t vts-v2dl3-dev -f Dockerfile .
```

Running

```
docker run --rm -it -v "$(pwd)/data_v486:/data" -v "$(pwd)/V2DL3:/v2dl3" vts-v2dl3-dev bash
cd /v2dl3
pip install  --use-feature=in-tree-build --upgrade-strategy only-if-needed  .
```
 v2dl3 -f /data/64080.anasum.root /data/effArea-v486-auxv01-CARE_June2020-Cut-NTel2-PointSource-Moderate-TMVA-BDT-GEO-V6_2012_2013a-ATM62-T1234.root /data/pointlike/64080.fits.gz > /data/pointlike/64080.v2dl3.log
 v2dl3 --full-enclosure -f /data/64080.anasum.root /data/effArea-v486-auxv01-CARE_June2020-Cut-NTel2-PointSource-Moderate-TMVA-BDT-GEO-V6_2012_2013a-ATM62-T1234.root /data/fullenclosure/64080.fits.gz > /data/fullenclosure/64080.v2dl3.log
```

## 0.2.0

```
 docker run --rm -it -v "$(pwd)/V2DL3_DL3array:/workdir/v2dl3" -v "$(pwd)/data_DL3array:/data" vts-v2dl3-dev-0.2.0 bash
docker run -e ENV_NAME=v2dl3 --rm -it -v "$(pwd)/V2DL3_DL3array:/workdir/v2dl3" -v "$(pwd)/data_DL3array:/data" vts-v2dl3-dev-0.2.0 bash
```
