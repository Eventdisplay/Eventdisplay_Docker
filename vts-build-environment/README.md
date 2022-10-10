# VERITAS Analysis Environments

(somewhat experimental)

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

## Testing

```
$ ./bin/evndisp -display=1 -sourcefile /CARE_June2020/gamma_V6_CARE_std_Atmosphere62_zen20deg_0.5wob_160MHz_1.vbf -sourcetype=2  -reconstructionparameter EVNDISP.reconstruction.runparameter.v4x
```
