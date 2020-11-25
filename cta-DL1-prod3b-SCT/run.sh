#!/bin/bash
#
# run a Eventdisplay DL1 analysis for CTA prod3b SCT simulations
#

if [ $# -lt 1 ]; then
	echo "
	./run.sh <sim_telarray file> [layout file]
	echo
	echo [layout file (optional)] e.g., CTA.prod3Sb.SCT.HB9.lis
	"
        exit
fi

DATAFILE=${1}
# default list file CTA.prod3Sb.SCT.hyperarray.lis
[[ "$2" ]] && LAYOUTFILE=$2 || LAYOUTFILE="CTA.prod3Sb.SCT.hyperarray.lis"
OUTPUTFILE=$(basename ${DATAFILE} .zst)
rm -f /tmp/${OUTPUTFILE}*

# calibration file
IPRFILE=${OBS_EVNDISP_AUX_DIR}/Calibration/prod3b/prod3b.Paranal-20171214.ped.root

###########
# file checks
if [[ ! -e ${IPRFILE} ]]; then
	echo "Error; IPR file not found: ${IPRFILE}"
	exit
fi
if [[ ! -e $OBS_EVNDISP_AUX_DIR/DetectorGeometry/${LAYOUTFILE} ]]; then
	echo "Error; Layout file not found: $OBS_EVNDISP_AUX_DIR/DetectorGeometry/${LAYOUTFILE}"
	exit
fi
if [[ ! -e ${DATAFILE} ]]; then
	echo "Error; sim_telarray file not found: ${DATAFILE}"
	exit
fi

###########
# run analysis
${EVNDISPSYS}/bin/CTA.convert_hessio_to_VDST -c ${IPRFILE} \
    -pe \
	-a $OBS_EVNDISP_AUX_DIR/DetectorGeometry/${LAYOUTFILE} \
	-o /tmp/${OUTPUTFILE}.dst.root \
	${DATAFILE} > /tmp/${OUTPUTFILE}.convert.log

# image squared weighting analysis (default)
$EVNDISPSYS/bin/evndisp -averagetzerofiducialradius=0.5 -imagesquared \
        -writeimagepixellist -ignoredstgains \
       	-reconstructionparameter EVNDISP.prod3.reconstruction.runparameter.NN.LL \
       	-sourcefile /tmp/${OUTPUTFILE}.dst.root \
       	-outputfile /tmp/${OUTPUTFILE}.root > /tmp/${OUTPUTFILE}.evndisp.log

# image linear weighting analysis (default)
$EVNDISPSYS/bin/evndisp -averagetzerofiducialradius=0.5 \
        -writeimagepixellist -ignoredstgains \
       	-reconstructionparameter EVNDISP.prod3.reconstruction.runparameter.NN.LL \
       	-sourcefile /tmp/${OUTPUTFILE}.dst.root \
       	-outputfile /tmp/${OUTPUTFILE}.lin.root > /tmp/${OUTPUTFILE}.evndisp.lin.log

###########
# cleanup
rm -f /tmp/${OUTPUTFILE}.dst.root
if [ -e /tmp/${OUTPUTFILE}.root ]; then
	# move log files into evndisp output file
	if [ -e /tmp/${OUTPUTFILE}.convert.log ]; then
		$EVNDISPSYS/bin/logFile convLog /tmp/${OUTPUTFILE}.root /tmp/${OUTPUTFILE}.convert.log
    fi
	if [ -e /tmp/${OUTPUTFILE}.evndisp.log ]; then
		$EVNDISPSYS/bin/logFile evndispLog /tmp/${OUTPUTFILE}.root /tmp/${OUTPUTFILE}.evndisp.log
    fi
	if [ -e /tmp/${OUTPUTFILE}.evndisp.lin.log ]; then
		$EVNDISPSYS/bin/logFile evndispLog /tmp/${OUTPUTFILE}.lin.root /tmp/${OUTPUTFILE}.evndisp.lin.log
    fi
	mv -f -v /tmp/${OUTPUTFILE}.root /data/
	mv -f -v /tmp/${OUTPUTFILE}.lin.root /data/
fi
