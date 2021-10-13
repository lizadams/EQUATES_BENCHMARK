#! /bin/csh -f
# script to download files matching query using gdrive
# # NOTE: Please use the gdrive executable for linux available from the CMAS Center Google Drive to avoid Error:403: Rate Limit Exceeded errors
# # see README Data Download Instructions https://docs.google.com/document/d/1e7B94zFkbKygVWfrhGwEZL51jF4fGXGXZbvi6KzXYQ4/edit
## NOTE: This is a EQUATES 2017 Data Download Script
# #
# # usage example 
# # ./SCRIPT_NAME
# # ./gdrive_download_equates_mcip.csh
#
# note, in this example, the script will download from December 15, 2016 to December 31, 2016
# note, this script does not handle changes in the calendar year
set pdate = 20161215 
set runto = 20161231


while ($pdate <= $runto)
	  echo "Process files ending in $pdate"
	   gdrive list --name-width 200 --absolute -q "trashed = false and name = 'MCIPv51_WRFv411_noltng_12US1.35L.${pdate}.tar'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0
	   tar -xvf MCIPv51_WRFv411_noltng_12US1.35L.${pdate}.tar 
	      @ pdate++

      end     #End of while loop
