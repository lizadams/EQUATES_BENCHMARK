#! /bin/csh -f

#SBATCH -t 4:00:00
#SBATCH -n 1
#SBATCH -J calc_tmetric
#SBATCH -p debug_queue
#SBATCH -o /proj/ie/proj/CMAS/EQUATES/CMAQv5.3.3/POST/EQUATES/logs/calc_tmetric_avg_monthly_combine_%j.log

set WORKDIR = /proj/ie/proj/CMAS/EQUATES/CMAQv5.3.3
set BINDIR = $WORKDIR/POST/calc_tmetric/scripts/BLD_calc_tmetric_v533_gcc

set EXEC = calc_tmetric_v533.exe

set TODAYG = ${START_DATE_H}
set YYYYMMDD = `date -ud "${TODAYG}" +%Y%m%d` #> Convert YYYY-MM-DD to YYYYMMDD
set YYYY = `date -ud "${TODAYG}" +%Y`
set YY = `date -ud "${TODAYG}" +%y`
set MM = `date -ud "${TODAYG}" +%m`
set DD = `date -ud "${TODAYG}" +%d`

set tomorrow_date = `date -ud "${TODAYG}+1days" +%Y-%m-%d`
set MMtomorrow = `date -ud "${tomorrow_date}" +%m`


setenv OPERATION AVG

setenv SPECIES_1 ALL

setenv M3_FILE_1 ${INFILE}
setenv M3_FILE_2
setenv M3_FILE_3
setenv M3_FILE_4
setenv M3_FILE_5 

setenv OUTFILE ${OUTFILE}

${BINDIR}/${EXEC}


#if ( ${MMtomorrow} != ${MM} ) then
	#  aput -q -retention=maximum -a ${ASMDIR_COMBINE1} ${OUTFILE}
	#endif


 exit() 
