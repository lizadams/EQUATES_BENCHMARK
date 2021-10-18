#! /bin/csh -f

#SBATCH -t 4:00:00
#SBATCH -n 1
#SBATCH -J calc_tmetric
#SBATCH -p debug_queue
#SBATCH -o /proj/ie/proj/CMAS/EQUATES/CMAQv5.3.3/POST/EQUATES/logs/calc_tmetric_avg_monthly_combine_%j.log

 set WORKDIR = /proj/ie/proj/CMAS/EQUATES/CMAQv5.3.2
 set BINDIR = $WORKDIR/POST/hr2day/scripts/BLD_hr2day_v532_gcc
 set EXEC = hr2day_v532.exe

#> Set to use local time for evaluation against observational data (default is GMT)
 setenv USELOCAL Y

#> Location of time zone data file, tz.csv (this is a required input file
#> when using USELOCAL Y to shift from GMT to local time)
 setenv TZFILE $WORKDIR/POST/bldoverlay/inputs/tz.csv

#> Set to use daylight savings time (default is N)
 setenv USEDST N

#> Partial day calculation (computes value for last day even 
#> if there are not 24 hours for that day after shift to LST)
 setenv PARTIAL_DAY Y

#> Number of 8hr values to use when computing daily maximum 8hr ozone.
#> Allowed values are 24 (use all 8-hr averages with starting hours 
#> from 0 - 23 hr local time) and 17 (use only the 17 8-hr averages
#> with starting hours from 7 - 23 hr local time)
 setenv HOURS_8HRMAX 24
# setenv HOURS_8HRMAX 17

#> define species (format: "Name, units, From_species, Operation")
#>  operations : {SUM, AVG, MIN, MAX, @MAXT, MAXDIF, 8HRMAX, SUM06}
 setenv SPECIES_1 "O3_MDA8,ppbV,O3,8HRMAX"
 setenv SPECIES_2 "O3_DAILYAV,ppbV,O3,AVG"
 setenv SPECIES_3 "O3_MAX,ppbV,O3,MAX"
 setenv SPECIES_4 "PM25_TOT_AVG,ug/m3,PM25_TOT,AVG" 
 setenv SPECIES_5 "PM25_SO4_AVG,ug/m3,PM25_SO4,AVG"
 setenv SPECIES_6 "PM25_NO3_AVG,ug/m3,PM25_NO3,AVG"
 setenv SPECIES_7 "PM25_NH4_AVG,ug/m3,PM25_NH4,AVG"
 setenv SPECIES_8 "PM25_OC_AVG,ug/m3,PM25_OC,AVG"
 setenv SPECIES_9 "PM25_EC_AVG,ug/m3,PM25_EC,AVG"

#> Set path and name of combine infile (this has already been set in the combine script)
 setenv M3_FILE_1 ${INFILE}

#> Set path and name of outfile (this has already been set in the combine script)
 setenv OUTFILE   ${OUTFILE} 

 ${BINDIR}/${EXEC}



 exit() 
