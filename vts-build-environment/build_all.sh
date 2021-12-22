#!/bin/sh
#
# build and push docker images

ROOT5=( vts-5.34.38-sl7 )
ROOT6=( vts-6.24.06-ubuntu20.04 )
ROOT6=( vts-6.22.06-fedora33 )
ROOT6=( vts-6.22.08-fedora34 )
ROOT6=( vts-6.22.08-centos7 )
VERSION="0.1"
VERSION=""

build_root5()
{
    for F in ${ROOT5}
    do
        echo "Building $F"
        cp -v tarpackages/root_v5.34.38.source.tar.gz ${F}/
        cp -v tarpackages/VBF-0.3.4.tar.gz ${F}/
        cd ${F}
        docker build --progress plain -t ${F} .
        rm -f VBF-0.3.4.tar.gz
        rm -f root_v5.34.38.source.tar.gz
        if [[ ! -z ${VERSION} ]]; then
            docker tag ${F} gernotmaier/${F}:${VERSION}
            docker push gernotmaier/${F}:${VERSION}
        fi

        # adding eventdisplay
#        git clone git@github.com:VERITAS-Observatory/EventDisplay_v4.git
#        git checkout -b ${F}
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
        docker build -t ${F} .
        rm -f VBF-0.3.4.tar.gz
        if [[ ! -z ${VERSION} ]]; then
            docker tag ${F} gernotmaier/${F}:${VERSION}
            docker push gernotmaier/${F}:${VERSION}
        fi

        # adding eventdisplay
#        git clone git@github.com:VERITAS-Observatory/EventDisplay_v4.git
#        git checkout -b ${F}
        cd ..
    done
}

#build_root6
build_root5
