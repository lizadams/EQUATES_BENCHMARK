#! /bin/csh -f
# script to download files matching query using gdrive
# # NOTE: Please use the gdrive executable for linux available from the CMAS Center Google Drive to avoid Error:403: Rate Limit Exceeded errors
# # see README Data Download Instructions https://docs.google.com/document/d/1e7B94zFkbKygVWfrhGwEZL51jF4fGXGXZbvi6KzXYQ4/edit
# #
# # usage example 
# # ./SCRIPT_NAME
# # ./gdrive_download_equates.icbc.csh
#
# in this example, the input files for the month of December 2016 will be downloaded
# note, the script does not handle change in calendar year
set year = 2016
set month = 12
set runto = 12


while ($month <= $runto)
	  echo "Process files ending in $month"
	   gdrive list --name-width 200 --absolute -q "trashed = false and name = 'BCON_CONC_12US1_CMAQv53_TS_108NHEMI_regrid_${year}${month}.nc'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0
	    gdrive list --name-width 200 --absolute -q "trashed = false and name = 'CCTM_CGRID_v532_cb6r3_ae7_aq_WR413_MYR_STAGE_${year}_12US1_${year}${month}15.nc'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0
          gdrive list --name-width 200 --absolute -q "trashed = false and name = 'CCTM_SOILOUT_v532_cb6r3_ae7_aq_WR413_MYR_STAGE_${year}_12US1_${year}${month}15.nc'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0 
         gdrive list --name-width 200 --absolute -q "trashed = false and name = 'CCTM_MEDIA_CONC_v532_cb6r3_ae7_aq_WR413_MYR_STAGE_${year}_12US1_${year}${month}15.nc'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0 
	      @ month++

      end     #End of while loop
