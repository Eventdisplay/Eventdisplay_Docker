# Eventdisplay slib

Container to use Eventdisplay root library

## Building

```
% docker build -t eventdisplay-cta-slib .
```

To build it with a different root version, do e.g., 
```
% docker build  --build-arg ROOTVERSION=6.22.00 -t eventdisplay-cta-6.22 .
```

## Running

To run the container in bash 

```
% docker run --rm -it -v "$(pwd)/:/workdir" eventdisplay-cta-slib bash
```
