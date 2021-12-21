#!/bin/sh
#
# build and push docker images

ROOT5=( vts-5.34.38-sl7 )
ROOT6=( vts-6.24.06-ubuntu20.04 )

build_root5()
{
    for F in ${ROOT5}
    do
        echo "Building $F"
        cp -v tarpackages/root_v5.34.38.source.tar.gz ${F}/
        cp -v tarpackages/VBF-0.3.4.tar.gz ${F}/
        cd ${F}
        docker build -t ${F} .
        rm -f ${F}/VBF-0.3.4.tar.gz
        rm -f ${F}/root_v5.34.38.source.tar.gz

        # adding eventdisplay
        git clone git@github.com:VERITAS-Observatory/EventDisplay_v4.git
        git checkout -b ${F}
        cd ..
    done
}

build_root6()
{
    for F in ${ROOT6}
    do
        echo "Building $F"
        cp -v tarpackages/VBF-0.3.4.tar.gz ${F}/
        cd ${F}
        docker build -t ${F} . --tag ${F}:$(date +%s)
        rm -f ${F}/VBF-0.3.4.tar.gz

        # adding eventdisplay
        git clone git@github.com:VERITAS-Observatory/EventDisplay_v4.git
        git checkout -b ${F}
        cd ..
    done
}

#build_root5
build_root6
