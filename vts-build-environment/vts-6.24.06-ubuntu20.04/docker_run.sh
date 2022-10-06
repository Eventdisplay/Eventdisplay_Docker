# Run docker image with X11 enabled
#
# following instructions on https://hub.docker.com/r/rootproject/root
#
# mounting local directory as workdir
#

[[ "$1" ]] && DDIR="-v $1:/data" || DDIR=""

ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $ip

echo "starting docker and mounting pwd to /data/"
if [[ -n "$DDIR" ]]; then
    echo "   mounting data dir to $1"
fi
docker run --rm -it  -v "$(pwd):/data/" $DDIR -v "/Volumes/fs01/VTS/CARE_June2020:/CARE_June2020" -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$ip:0 vts-6.24.06-ubuntu20.04 bash
