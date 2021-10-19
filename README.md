# EQUATES_Benchmark Sample Scripts

  This repository includes scripts to download EQUATES data from the CMAS Data Warehouse Google Drive and set up a CMAQv5.3.2 simulation using EQUATES input data.

  The directory structure mimics the input data directory structure used by the EQUATE CMAQ model run script.

  Directories include:
 
  1. Tutorials: Tutorial with instructions on how to build the libraries and CMAQv5.3.2 to read the compressed input data (*.nc4)
  
  2. CCTM/scripts: CMAQ Scripts to build and run CMAQv5.3.2 using EQUATES Input data to restart as the initial conditions.

  3. POST/EQUATES: Post-processing scripts called by the CMAQ run script that will create the post-processed output data (combine, hr2day and monthly average).

  4. gdrive_scripts/data/2017_12US1: scripts to download the EQUATES Input data from google drive

       The directory structure of the gdrive_scripts directory mimics the input data directory structure used by the EQUATES CMAQ Model run script.
       NOTE: Please use the gdrive executable for linux available from the CMAS Center Google Drive to avoid Error:403: Rate Limit Exceeded errors
       See README Data Download Instructions https://docs.google.com/document/d/1e7B94zFkbKygVWfrhGwEZL51jF4fGXGXZbvi6KzXYQ4


  
  Obtain the EQUATES_Benchmark github repository using the command:


```
git clone -b main https://github.com/lizadams/EQUATES_BENCHMARK.git EQUATES_BENCHMARK
```
