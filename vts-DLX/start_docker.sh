# open root and enable graphics using XQuartz
#
# following instructions on https://hub.docker.com/r/rootproject/root
#
# mounting local directory as workdir
#

[[ "$1" ]] && DDIR="-v $1:/data" || DDIR=""

ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $ip

echo "starting docker and mounting pwd to /workdir"
if [[ -n "$DDIR" ]]; then
    echo "   mounting data dir to $1"
fi
docker run --rm -it \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "$(pwd)/data:/data/" \
    -e DISPLAY=$ip:0 gernotmaier/eventdisplay-vts-dl1:v01 bash
