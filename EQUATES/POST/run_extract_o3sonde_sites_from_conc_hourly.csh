#!/bin/csh
#SBATCH -t 4:00:00
#SBATCH -n 1
#SBATCH -J o3sonde
#SBATCH -p debug_queue
#SBATCH -o /proj/ie/proj/CMAS/EQUATES/CMAQv5.3.3/POST/EQUATES/logs/extract_o3sonde_sites_from_conc_cmaqv53_ts_%j.txt

set WORKDIR = /proj/ie/proj/CMAS/EQUATES/CMAQv5.3.3

set EXEC = run_extract_o3sonde_sites_from_conc_hourly.csh

set TODAYG = ${START_DATE}
set YYYYMMDD = `date -ud "${TODAYG}" +%Y%m%d` #> Convert YYYY-MM-DD to YYYYMMDD
set YYYY = `date -ud "${TODAYG}" +%Y`
set YY = `date -ud "${TODAYG}" +%y`
set MM = `date -ud "${TODAYG}" +%m`
set DD = `date -ud "${TODAYG}" +%d`

set tomorrow_date = `date -ud "${TODAYG}+1days" +%Y-%m-%d`
set MMtomorrow = `date -ud "${tomorrow_date}" +%m`

setenv SITEFILE $WORKDIR/POST/EQUATES/station_list_o3sondes_combined_NH_sorted_by_lat.csv

setenv CCTM_CONC ${CCTMOUTDIR}/${CCTM_CONC_NAME}_${YYYY}${MM}${DD}.nc

setenv MET_CRO_3D ${MET_CRO_3D}

setenv OUTFILE ${POSTDIR}/O3SONDE_PROFILES_${RUNID}_${YYYY}${MM}.nc



cd ${WORKDIR}

${EXEC}

if ( ${MMtomorrow} != ${MM} ) then
	#  aput -q -retention=maximum -a ${ASMDIR_COMBINE1} ${OUTFILE}
endif


 exit() 
