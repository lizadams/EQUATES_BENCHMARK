# EQUATES Benchmark Sample Scripts

This repository includes scripts to download EQUATES data from the CMAS Data Warehouse Google Drive and set up a CMAQv5.3.2.1 simulation using input data from the EPA's Air Quality Time Series (EQUATES) Project. Visit www.epa.gov/cmaq/EQUATES for more information about the EQUATES project. 

## Software requirements for using EQUATES model input data to run CMAQ
The EQUATES datasets include CMAQ-ready emissions, meteorology, and IC/BC files that can be used for running CMAQ on the 12US1 domain. 
EQUATES emissions and meteorolgoy datasets have been compressed using netcdf4 compression to save disk space. CMAQ can be run using the compressed files directly (i.e., no need to uncompress the files first), however this requires the installation of a specific libraries prior to running CMAQ.  See the EQUATES CMAQ tutorial for specific instructions. 


## EQUATES Benchmark Repository Guide
Documentation and sample scripts are organized as follows:
  1. [Tutorial](Tutorials): Tutorial with instructions on how to build CMAQv5.3.2.1 to use EQUATES input data including the required libraries for reading the compressed input files (*.nc4).  
  
  2. [EQUATES Build and Run Scripts](CCTM/scripts): CMAQ scripts to build and run CMAQv5.3.2.1 using EQUATES input data to restart as the initial conditions.

  3. [EQUATES Post Processing Scripts](POST/EQUATES): Post-processing scripts called by the CMAQ run script that will create the post-processed output data (combine, hr2day and monthly average).

  4. EQUATES used CMAQv5.3.2.1, a version based on CMAQv5.3.2 that includes bugfixes numbered 2, 9, 11, 13, and 14 in the v5.3.3 bugfix page    https://github.com/USEPA/CMAQ/blob/5.3.2/DOCS/Release_Notes/CMAQv5.3.2_bugfixes.md  See the tutorial for instructions to download this version of CMAQ, if you are intending to reproduce the EQUATES benchmark case.

  5. [gdrive download scripts](gdrive_scripts/data/2017_12US1): scripts to download the EQUATES Input data from google drive

The directory structure of the gdrive_scripts directory mimics the input data directory structure used by the EQUATES CMAQ Model run script.
       NOTE: Please use the gdrive executable for linux available from the CMAS Center Google Drive to avoid Error:403: Rate Limit Exceeded errors
       See README Data Download Instructions https://docs.google.com/document/d/1e7B94zFkbKygVWfrhGwEZL51jF4fGXGXZbvi6KzXYQ4


  
  Obtain the EQUATES_Benchmark github repository using the command:


```
git clone -b main https://github.com/lizadams/EQUATES_BENCHMARK.git EQUATES_BENCHMARK
```
