# VERITAS ROOT-generic

Generic VERITAS docker images for development and testing.

Baseimages from: https://github.com/root-project/root-docker

## Building

Use the build script `../build_all.sh`.

## Running

Run the image and provide a bash environment:

```
$ docker run --rm -it -v "$(pwd):/data" vts-image bash
```

Replace `vts-image` by the corresponding image name.

## Development image

Expect code outside of the images.
