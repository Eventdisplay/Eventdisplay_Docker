# V2DL3 Docker file for ROOT-to-FITS conversion

Docker file to convert VERITAS Eventdisplay anasum files to DL3 FITS using the V2DL3 converter. 

Note that V2DL3 is unfortunately private software.

## Building

```
$ docker build --build-arg GITUSER="my-git-username" --build-arg GITPW="my-gitpassword" -t vts-v2dl3 .
```

## Running

Run the image and provide a bash environment:

```
$ docker run --rm -it vts-v2dl3 bash
```
