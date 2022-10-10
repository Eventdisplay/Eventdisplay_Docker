#!/bin/sh
#
# build and push docker images
#
# available root images from https://hub.docker.com/r/rootproject/root

# use Dockerfile-dev for development version
DOCKERFILE="Dockerfile-dev"

# code versions
EVNDISP_VERSION="v490-dev-v0.7"
SOFA_VERSION="20210512"

ROOT5=( vts-5.34.38-sl7 )
ROOT6cpp17=( latest 6.26.06-ubuntu22.04 6.26.06-fedora35 )
ROOT6cpp11=( 6.24.06-centos7 6.22.08-ubuntu20.04 )

# TESTING
ROOT6cpp17=( 6.26.06-fedora35 )
ROOT6cpp11=( 6.24.06-centos7 )
ROOT6cpp17=( latest )

VERSION="0.1"
VERSION=""


# download code packages required for analysis
prepare_code_packages()
{
    # eventdisplay
    git clone -b ${EVNDISP_VERSION} --single-branch git@github.com:VERITAS-Observatory/EventDisplay_v4.git
    tar -czf tarpackages/EventDisplay_v4-${EVNDISP_VERSION}.tar.gz EventDisplay_v4
    rm -rf EventDisplay_v4
    # sofa
    wget https://syncandshare.desy.de/index.php/s/jr9NrbWFR5MLaDf/download
    mv download tarpackages/sofa_c-${SOFA_VERSION}.tar.gz
    # VBF
    wget https://syncandshare.desy.de/index.php/s/NrnZNKfT8WxFpcn/download
    mv download tarpackages/VBF-0.3.4-cpp17.tar.gz
    wget https://syncandshare.desy.de/index.php/s/gR5EtCo7PbpCpN5/download
    mv download tarpackages/VBF-0.3.4.tar.gz
}


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
        # if [[ ! -z ${VERSION} ]]; then
        #    docker tag ${F} gernotmaier/${F}:${VERSION}
        #    docker push gernotmaier/${F}:${VERSION}
        #fi

        # adding eventdisplay
#        git clone git@github.com:VERITAS-Observatory/EventDisplay_v4.git
#        git checkout -b ${F}
        cd ..
    done
}

build_root6()
{
    build_dir="./vts-generic/"
    for F in $2
    do
        echo "Building $F"
        cp -f -v "tarpackages/${3}" "${build_dir}/VBF.tar.gz"
        cp -f -v tarpackages/EventDisplay_v4-${EVNDISP_VERSION}.tar.gz ${build_dir}/EventDisplay_v4.tar.gz
        cp -f -v tarpackages/sofa_c-${SOFA_VERSION}.tar.gz ${build_dir}/sofa.tar.gz
        cd "${build_dir}" || exit
        docker build -f "${1}" -t "vts-${F}" --build-arg "ROOT_VERSION=${F}" .
#        if [[ ! -z ${VERSION} ]]; then
#            docker tag ${F} gernotmaier/${F}:${VERSION}
#            docker push gernotmaier/${F}:${VERSION}
#        fi

        cd ..
    done
}

# prepare_code_packages
build_root6 ${DOCKERFILE} "${ROOT6cpp17}" "VBF-0.3.4-cpp17.tar.gz"
# build_root6 ${DOCKERFILE} "${ROOT6cpp11}" "VBF-0.3.4.tar.gz"
# build_root5
