#! /bin/csh -f
# script to download files matching query using gdrive
# # NOTE: Please use the gdrive executable for linux available from the CMAS Center Google Drive to avoid Error:403: Rate Limit Exceeded errors
# # see README Data Download Instructions https://docs.google.com/document/d/1e7B94zFkbKygVWfrhGwEZL51jF4fGXGXZbvi6KzXYQ4/edit
# #
# # usage example 
# # ./SCRIPT_NAME
# # ./gdrive_download_equates.icbc.csh
#
#
# use months 01, 02, 03, etc
# in this example, the input files for the month of January 2017 will be downloaded
set pdate = 01
set runto = 02


while ($pdate < $runto)
	  echo "Process files ending in $pdate"
	   gdrive list --name-width 200 --absolute -q "trashed = false and name = 'BCON_CONC_12US1_CMAQv53_TS_108NHEMI_regrid_2017${pdate}.nc'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0
	    gdrive list --name-width 200 --absolute -q "trashed = false and name = 'CCTM_CGRID_v532_cb6r3_ae7_aq_WR413_MYR_STAGE_2017_12US1_2017${pdate}01.nc'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0
	      @ pdate++

      end     #End of while loop
