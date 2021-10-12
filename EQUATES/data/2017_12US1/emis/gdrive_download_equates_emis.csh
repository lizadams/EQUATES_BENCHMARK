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
# in this example, the emissions inputs for the month of January 2017 will be downloaded
set pdate = 01
set runto = 02

gdrive list --name-width 200 --absolute -q "trashed = false and name = 'static_emis_files_EQUATES_v1.0.tar'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0
gdrive list --name-width 200 --absolute -q "trashed = false and name = 'model_ready_emis_2017_stackgroups_epicsoil_EQUATES_v1.0.tar'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0

while ($pdate < $runto)
   echo "Process files ending in $pdate"
   gdrive list --name-width 200 --absolute -q "trashed = false and name = 'epic_files_2017_${pdate}_EQUATES_v1.0.tar'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0
   gdrive list --name-width 200 --absolute -q "trashed = false and name = 'model_ready_emis_2017_merged_nobeis_norwc_${pdate}_EQUATES_v1.0.tar'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0
   gdrive list --name-width 200 --absolute -q "trashed = false and name = 'model_ready_emis_ptsectors_plus_rwc_2017_${pdate}_EQUATES_v1.0.tar'" --no-header  | cut -d " " -f1 - | xargs -L 1 gdrive download -r --timeout 0
	      @ pdate++

      end     #End of while loop
