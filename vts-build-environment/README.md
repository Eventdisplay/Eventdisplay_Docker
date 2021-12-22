# VERITAS Analysis Environments

Images are available for:

- sl7, root-5.34.36
- vts-6.24.06-ubuntu20.04, C++14 support
- vts-6.22.08-fedora34, C++17 support
- vts-6.22.06-fedora33, C++14 support
- vts-6.22.08-centos7, C++11 support

## Build all images

Run (takes a while):
```
./build_all.sh
```

## Eventdisplay_v4 compilation

- [x] vts-5.34.38-sl7
- [x] vts-6.24.06-ubuntu20.04
- [ ] vts-6.22.08-fedora34 (VBF fails compilation)
- [ ] vts-6.22.06-fedora33 (evndisp fails compilation without minuit, mva)
- [ ] vts-6.22.08-centos7 (evndisp fails compilation without minuit, mva)
