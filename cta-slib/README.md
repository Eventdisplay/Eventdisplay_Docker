# Eventdisplay slib

Container to use Eventdisplay root library

## Building

```
$ docker build -t eventdisplay-cta-slib .
```

## Running

To run the container in bash 

```
$ docker run --rm -it -v "$(pwd)/data:/data" eventdisplay-cta-slib bash
```