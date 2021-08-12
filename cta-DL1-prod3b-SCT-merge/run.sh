#!/bin/bash
#
# Analysis of prod3b Alpha + SCT hyperarray
#
# 1. extract proxy to alpha layout
# 2. merge with SCT hyper array
# 3. run Eventdisplay DL1 analysis
#
# Based on scripts from K.Bernloehr (MPIK) and G.Maier (DESY)
# 

if [ $# -lt 2 ]; then
	echo "
	./run.sh <prod3b file> <prod3b SCT file>
	echo
	"
    exit
fi
ALPHAFILE=${1}
SCTFILE=${2}
if [[ ! -e ${1} ]] || [[ ! -e ${2} ]]; then
    echo "error: data files not found"
    exit
fi

DDIR="/data"
################################
# telescope list
if [ ! -f ${DDIR}/CTA.prod3bS-M6C5a-14MSTs37SSTs-MSTF-1.map ]; then
   sed 's/^/1 /' < ${WORKDIR}/CTA.prod3bS-M6C5a-14MSTs37SSTs-MSTF.lis > ${DDIR}/CTA.prod3bS-M6C5a-14MSTs37SSTs-MSTF-1.map
fi
if [ ! -f ${DDIR}/merge.map ]; then
   echo "1 1-51" > ${DDIR}/merge.map
   echo "2 1-41" >> ${DDIR}/merge.map
fi

################################
# extract alpha layout
# (save LD_LIBRARY)
LD_LIBRARY_PATH_SAVE=${LD_LIBRARY_PATH}
unset LD_LIBRARY_PATH
# temporary alpha file (extracted)
f1x=$(echo "${ALPHAFILE}" | sed 's/-merged/-extracted/')
${WORKDIR}/hessioxxx-extract/bin/extract_simtel \
    --map-file ${DDIR}/CTA.prod3bS-M6C5a-14MSTs37SSTs-MSTF-1.map \
    --min-trg-tel 1 \
    "${ALPHAFILE}" "$f1x" || exit 1

################################
# merge with SCT layout
DATAFILE=$(echo "${ALPHAFILE}" | sed 's/-merged/-final/')
${WORKDIR}/hessioxxx/bin/merge_simtel \
    --min-trg-tel 2 --dist-sep 20 \
    ${DDIR}/merge.map \
    "$f1x" "${SCTFILE}" "$DATAFILE" || exit 1

################################
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH_SAVE}
echo ${LD_LIBRARY_PATH}

OUTPUTFILE=$(basename ${DATAFILE} .zst)
rm -f /tmp/${OUTPUTFILE}*
LAYOUTFILE="CTA.prod3bS.SCT-Alpha.hyperarray.lis"
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
	-a $OBS_EVNDISP_AUX_DIR/DetectorGeometry/${LAYOUTFILE} \
	-o /tmp/${OUTPUTFILE}.dst.root \
	${DATAFILE} > /tmp/${OUTPUTFILE}.convert.log

$EVNDISPSYS/bin/evndisp -averagetzerofiducialradius=0.5 -imagesquared \
       	-reconstructionparameter EVNDISP.prod3.reconstruction.runparameter.NN.LL \
        -ignoredstgains \
       	-sourcefile /tmp/${OUTPUTFILE}.dst.root \
       	-outputfile /tmp/${OUTPUTFILE}.root > /tmp/${OUTPUTFILE}.evndisp.log

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
    mv -f -v /tmp/${OUTPUTFILE}.root /data/
fi
