#! /bin/csh -f

#SBATCH -t 4:00:00
#SBATCH -n 1
#SBATCH -J calc_tmetric
#SBATCH -p debug_queue
#SBATCH -o /proj/ie/proj/CMAS/EQUATES/CMAQv5.3.2/POST/EQUATES/logs/calc_tmetric_sum_monthly_combine_%j.log

set BINDIR = /proj/ie/proj/CMAS/EQUATES/CMAQv5.3.2/POST/calc_tmetric/scripts/BLD_calc_tmetric_v532_gcc

set EXEC = calc_tmetric_v532.exe

set TODAYG = ${START_DATE_H}
set YYYYMMDD = `date -ud "${TODAYG}" +%Y%m%d` #> Convert YYYY-MM-DD to YYYYMMDD
set YYYY = `date -ud "${TODAYG}" +%Y`
set YY = `date -ud "${TODAYG}" +%y`
set MM = `date -ud "${TODAYG}" +%m`
set DD = `date -ud "${TODAYG}" +%d`

set tomorrow_date = `date -ud "${TODAYG}+1days" +%Y-%m-%d`
set MMtomorrow = `date -ud "${tomorrow_date}" +%m`

setenv OPERATION SUM

setenv SPECIES_1 ALL

setenv M3_FILE_1 ${INFILE}
setenv M3_FILE_2
setenv M3_FILE_3
setenv M3_FILE_4
setenv M3_FILE_5 
setenv M3_FILE_6
setenv M3_FILE_7

setenv OUTFILE ${OUTFILE}

${BINDIR}/${EXEC}


exit()
