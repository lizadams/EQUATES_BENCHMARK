#!/bin/csh
#SBATCH -t 4:00:00
#SBATCH -n 1
#SBATCH -J combine
#SBATCH -p debug_queue
#SBATCH -o /proj/ie/proj/CMAS/EQUATES/CMAQv5.3.2/POST/EQUATES/logs/combine_cmaqv53_ts_aconc_dep_conc_cb6r3_ae7_aq_batch_%j.txt

set WORKDIR = /proj/ie/proj/CMAS/EQUATES/CMAQv5.3.2
set EQPOSTSCR = $WORKDIR/POST/EQUATES

set SPEC_CONC = $EQPOSTSCR/SpecDef_aconc_cmaqv53_ts_cb6r3_ae7_aq.txt
set SPEC_PHOT = $EQPOSTSCR/SpecDef_photdiag_cmaqv53_ts_cb6r3_ae7_aq.txt
set SPEC_DEP = $EQPOSTSCR/SpecDef_dep_cmaqv53_ts_cb6r3_ae7_aq.txt
set SPEC_EMIS = $EQPOSTSCR/SpecDef_inline_emis_equates_12us1.txt
set SPEC_CONC_3D = $EQPOSTSCR/SpecDef_conc3d_cmaqv53_ts_cb6r3_ae7_aq.txt

setenv GENSPEC N

set BLD_DIR = $WORKDIR/POST/combine/scripts/BLD_combine_v532_gcc

set EXEC = combine_v532.exe

set VRSN = v532
set compilerString = gcc

#set RUNID = ${VRSN}_${compilerString}_${APPL}

if ( ! -e $POSTDIR ) then
 mkdir $POSTDIR
endif


#> Set Start and End Days for looping
set START_DATE = ${START_DATE_H}     #> beginning date from the calling run script
set END_DATE   = ${END_DATE_H}     #> ending date from the calling run script

#> Loop through all days between START_DAY and END_DAY
set TODAYG = ${START_DATE}
set TODAYJ = `date -ud "${START_DATE}" +%Y%j` #> Convert YYYY-MM-DD to YYYYJJJ
set STOP_DAY = `date -ud "${END_DATE}" +%Y%j` #> Convert YYYY-MM-DD to YYYYJJJ

while ($TODAYJ <= $STOP_DAY )  #>Compare dates in terms of YYYYJJJ
 
#> Retrieve Calendar day Information
 set YYYY = `date -ud "${TODAYG}" +%Y`
 set YY = `date -ud "${TODAYG}" +%y`
 set MM = `date -ud "${TODAYG}" +%m`
 set DD = `date -ud "${TODAYG}" +%d`
#> for files that are indexed with Julian day:
#  set YYYYJJJ = `date -ud "${TODAYG}" +%Y%j` 
#> Calculate the month for tomorrow.
 set tomorrow_date = `date -ud "${TODAYG}+1days" +%Y-%m-%d`
 set MMtomorrow = `date -ud "${tomorrow_date}" +%m`

#
# ACONC first
#

 setenv SPECIES_DEF $SPEC_CONC

#> Define name of combine output file to save hourly average concentration.
#> A new file will be created for each month/year.
 setenv OUTFILE ${POSTDIR}/COMBINE_ACONC_${RUNID}_${YYYY}${MM}.nc

#> Define name of input files needed for combine program.
  #> File [1]: CMAQ conc/aconc file
  #> File [2]: MCIP METCRO3D file
  #> File [3]: CMAQ APMDIAG file
  #> File [4]: MCIP METCRO2D file
  #> File [5]: CMAQ PHOTDIAG1 file
   setenv INFILE1 $CCTMOUTDIR/CCTM_ACONC_${RUNID}_$YYYY$MM$DD.nc
   setenv INFILE2 ${MET_CRO_3D}
   setenv INFILE3 $CCTMOUTDIR/CCTM_APMDIAG_${RUNID}_$YYYY$MM$DD.nc
   setenv INFILE4 ${MET_CRO_2D}
   setenv INFILE5 

#> Executable call:
 ${BLD_DIR}/${EXEC}

# if this is the last day of the month run calc_tmetric for monthly averages
  if ( ${MMtomorrow} != ${MM} ) then
   setenv INFILE ${POSTDIR}/COMBINE_ACONC_${RUNID}_${YYYY}${MM}.nc
   setenv OUTFILE ${POSTDIR}/COMBINE_ACONC_${RUNID}_${YYYY}${MM}_av.nc
   sbatch --export=ALL $EQPOSTSCR/calc_tmetric_avg_monthly_combine_batch.csh
 endif

# if this is the last day of the month run hr2day for daily averages
  if ( ${MMtomorrow} != ${MM} ) then
   setenv INFILE ${POSTDIR}/COMBINE_ACONC_${RUNID}_${YYYY}${MM}.nc
   setenv OUTFILE ${POSTDIR}/HR2DAY_ACONC_${RUNID}_${YYYY}${MM}.nc
   sbatch --export=ALL $EQPOSTSCR/hr2day_daily_averages_batch.csh
 endif

#
# PHOTDIAG1 next
#

 setenv SPECIES_DEF $SPEC_PHOT

#> Define name of combine output file to save hourly average concentration.
#> A new file will be created for each month/year.
 setenv OUTFILE ${POSTDIR}/COMBINE_COLUMN_${RUNID}_${YYYY}${MM}.nc

#> Define name of input files needed for combine program.
  #> File [1]: CMAQ conc/aconc file
  #> File [2]: MCIP METCRO3D file
  #> File [3]: CMAQ APMDIAG file
  #> File [4]: MCIP METCRO2D file
  #> File [5]: CMAQ PHOTDIAG1 file
   setenv INFILE1 $CCTMOUTDIR/CCTM_PHOTDIAG1_${RUNID}_$YYYY$MM$DD.nc
   setenv INFILE2 
   setenv INFILE3 
   setenv INFILE4 
   setenv INFILE5 

#> Executable call:
 ${BLD_DIR}/${EXEC}

# if this is the last day of the month run calc_metric for monthly averages

  if ( ${MMtomorrow} != ${MM} ) then
    setenv INFILE ${POSTDIR}/COMBINE_COLUMN_${RUNID}_${YYYY}${MM}.nc
    setenv OUTFILE ${POSTDIR}/COMBINE_COLUMN_${RUNID}_${YYYY}${MM}_av.nc
    sbatch --export=ALL $EQPOSTSCR/calc_tmetric_avg_monthly_combine_batch.csh
  endif


#
# DEP NEXT
#

 setenv SPECIES_DEF $SPEC_DEP

#> Define name of combine output file to save hourly average concentration.
#> A new file will be created for each month/year.
 setenv OUTFILE ${POSTDIR}/COMBINE_DEP_${RUNID}_${YYYY}${MM}.nc

#> Define name of input files needed for combine program.
  #> File [1]: CMAQ DRYDEP file
  #> File [2]: CMAQ WETDEP file
  #> File [3]: MCIP METCRO2D
  #> File [4]: {empty}
  #> File [5]: {empty}
   setenv INFILE1 $CCTMOUTDIR/CCTM_DRYDEP_${RUNID}_$YYYY$MM$DD.nc
   setenv INFILE2 $CCTMOUTDIR/CCTM_WETDEP1_${RUNID}_$YYYY$MM$DD.nc
   setenv INFILE3 ${MET_CRO_2D}
   setenv INFILE4 $CCTMOUTDIR/CCTM_DEPV_${RUNID}_$YYYY$MM$DD.nc
   setenv INFILE5 $CCTMOUTDIR/CCTM_CONC_${RUNID}_$YYYY$MM$DD.nc
   setenv INFILE6 ${MET_CRO_3D}

#> Executable call:
 ${BLD_DIR}/${EXEC}

# if this is the last day of the month run calc_tmetric to compute monthly sum
  if ( ${MMtomorrow} != ${MM} ) then
    setenv INFILE ${POSTDIR}/COMBINE_DEP_${RUNID}_${YYYY}${MM}.nc
    setenv OUTFILE ${POSTDIR}/COMBINE_DEP_${RUNID}_${YYYY}${MM}_sum.nc
    sbatch --export=ALL $EQPOSTSCR/calc_tmetric_sum_monthly_combine_batch.csh
  endif


## INLINE EMISSIONS NEXT

 setenv SPECIES_DEF $SPEC_EMIS

 #> Define name of combine output file to save hourly average concentration.
 #> A new file will be created for each month/year.
  setenv OUTFILE ${POSTDIR}/COMBINE_INLINE_EMIS_${RUNID}_${YYYY}${MM}.nc

  #> Define name of input files needed for combine program.
  #> File [1]: CMAQ DRYDEP file
  #> File [2]: CMAQ LTNGCOL file
  #> File [3]: CMAQ B3GTS_S file
  #> File [4]: MCIP GRIDCRO2D
  #> File [5]: {empty}

  setenv INFILE1 $CCTMOUTDIR/CCTM_DRYDEP_${RUNID}_$YYYY$MM$DD.nc
  setenv INFILE2 $CCTMOUTDIR/CCTM_LTNGCOL_${RUNID}_$YYYY$MM$DD.nc
  setenv INFILE3 $CCTMOUTDIR/CCTM_B3GTS_S_${RUNID}_$YYYY$MM$DD.nc
  setenv INFILE4 ${GRID_CRO_2D}
  setenv INFILE5
  setenv INFILE6

#> Executable call:
 ${BLD_DIR}/${EXEC}

# if this is the last day of the month run calc_tmetric to compute monthly sum
  if ( ${MMtomorrow} != ${MM} ) then
    setenv INFILE ${POSTDIR}/COMBINE_INLINE_EMIS_${RUNID}_${YYYY}${MM}.nc
    setenv OUTFILE ${POSTDIR}/COMBINE_INLINE_EMIS_${RUNID}_${YYYY}${MM}_sum.nc
    sbatch --export=ALL $EQPOSTSCR/calc_tmetric_sum_monthly_combine_batch.csh
  endif

#
# CONC3D last
#

 setenv SPECIES_DEF $SPEC_CONC_3D

#> Define name of combine output file to save hourly average concentration.
#> A new file will be created for each month/year.
 setenv OUTFILE ${POSTDIR}/COMBINE_CONC3D_${RUNID}_${YYYY}${MM}.nc

#> Define name of input files needed for combine program.
  #> File [1]: CMAQ conc/aconc file
  #> File [2]: MCIP METCRO3D file
  #> File [3]: 
  #> File [4]: 
  #> File [5]: 
   setenv INFILE1 $CCTMOUTDIR/CCTM_CONC_${RUNID}_$YYYY$MM$DD.nc
   setenv INFILE2 ${MET_CRO_3D}
   setenv INFILE3 
   setenv INFILE4 
   setenv INFILE5 
   setenv INFILE6

#> Executable call:
 ${BLD_DIR}/${EXEC}

# if this is the last day of the month run calc_tmetric to compute monthly averages
  if ( ${MMtomorrow} != ${MM} ) then
    setenv INFILE ${POSTDIR}/COMBINE_CONC3D_${RUNID}_${YYYY}${MM}.nc
    setenv OUTFILE ${POSTDIR}/COMBINE_CONC3D_${RUNID}_${YYYY}${MM}_av.nc
    sbatch --export=ALL $EQPOSTSCR/calc_tmetric_avg3d_monthly_combine_batch.csh
  endif

#> Increment both Gregorian and Julian Days
 set TODAYG = `date -ud "${TODAYG}+1days" +%Y-%m-%d` #> Add a day for tomorrow
 set TODAYJ = `date -ud "${TODAYG}" +%Y%j` #> Convert YYYY-MM-DD to YYYYJJJ

end #Loop to the next Simulation Day




