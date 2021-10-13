#! /bin/csh -f
# script to download files matching query using gdrive
# # NOTE: Please use the gdrive executable for linux available from the CMAS Center Google Drive to avoid Error:403: Rate Limit Exceeded errors
# # see README Data Download Instructions https://docs.google.com/document/d/1e7B94zFkbKygVWfrhGwEZL51jF4fGXGXZbvi6KzXYQ4/edit
# #
# # usage example 
# # ./SCRIPT_NAME
# # ./gdrive_download_equates_emis.csh
#
#
#set the month to be downloaded
# in this example, the emissions inputs for the month of December 2016 will be downloaded
set year = 2016
set month = 12
set runto = 12

gdrive list --name-width 200 --absolute -q "trashed = false and name = 'static_emis_files_EQUATES_v1.0.tar'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0
gdrive list --name-width 200 --absolute -q "trashed = false and name = 'model_ready_emis_${year}_stackgroups_epicsoil_EQUATES_v1.0.tar'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0

while ($month <= $runto)
   echo "Process files ending in $month"
   gdrive list --name-width 200 --absolute -q "trashed = false and name = 'epic_files_${year}_${month}_EQUATES_v1.0.tar'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0
   gdrive list --name-width 200 --absolute -q "trashed = false and name = 'model_ready_emis_${year}_merged_nobeis_norwc_${month}_EQUATES_v1.0.tar'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0
   gdrive list --name-width 200 --absolute -q "trashed = false and name = 'model_ready_emis_ptsectors_plus_rwc_${year}_${month}_EQUATES_v1.0.tar'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0
	      @ month++

      end     #End of while loop
