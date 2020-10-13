#!/bin/bash
#
# run a Eventdisplay DL1 analysis for CTA prod5 simulations
#

if [ $# -lt 2 ]; then
	echo "
	./run.sh <sim_telarray file> <layout file>
	echo
	echo <layout file>   e.g., CTA.prod5S.BL-4LSTs25MSTs70SSTs-MSTF.lis
	"
        exit
fi

DATAFILE=${1}
LAYOUTFILE=${2}
OUTPUTFILE=$(basename ${DATAFILE} .zst)
rm -f /tmp/${OUTPUTFILE}*

# select correct calibration file
if [[ $DATAFILE == *"dark"* ]]; then
	IPRFILE=${OBS_EVNDISP_AUX_DIR}/Calibration/prod5/prod5-IPR.root
else
	IPRFILE=${OBS_EVNDISP_AUX_DIR}/Calibration/prod5/prod5-halfmoon-IPR.root
fi

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
	-a $OBS_EVNDISP_AUX_DIR/DetectorGeometry/${LAYOUTFILE} \
	-o /tmp/tmp.dst.root \
	${DATAFILE} > /tmp/${OUTPUTFILE}.convert.log

$EVNDISPSYS/bin/evndisp -averagetzerofiducialradius=0.5 -imagesquared \
       	-reconstructionparameter EVNDISP.prod5.reconstruction.runparameter \
       	-sourcefile /tmp/tmp.dst.root \
       	-outputfile /tmp/${OUTPUTFILE}.root > /tmp/${OUTPUTFILE}.evndisp.log

###########
# cleanup
if [ -e /tmp/${OUTPUTFILE}.root ]; then
	# move log files into evndisp output file
	if [ -e /tmp/${OUTPUTFILE}.convert.log ]; then
		$EVNDISPSYS/bin/logFile convLog /tmp/${OUTPUTFILE}.root /tmp/${OUTPUTFILE}.convert.log
        fi
	if [ -e /tmp/${OUTPUTFILE}.evndisp.log ]; then
		$EVNDISPSYS/bin/logFile evndispLog /tmp/${OUTPUTFILE}.root /tmp/${OUTPUTFILE}.evndisp.log
        fi
	mv -f -v /tmp/${OUTPUTFILE}.root /data/
fi
