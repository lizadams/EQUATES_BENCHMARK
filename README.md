# EQUATES Benchmark 

  This github repository includes scripts and tutorials required to run a benchmark for EQUATES and includes:

  1. Tutorial with instructions on how to build the libraries and CMAQv5.3.2 to read the compressed input data (*.nc4)
  
  2. CMAQ Scripts to build and run CMAQv5.3.2 using EQUATES Input data to restart as the initial conditions.

  3. Post-processing scripts called by the CMAQ run script that will create the post procecessed output data (combine, hr2day and monthly average).

  4. scripts to download the EQUATES Input data from google drive

  The directory structure of the gdrive_scripts directory mimics the input data directory structure used by the EQUATES CMAQ Model run script.

  NOTE: Please use the gdrive executable for linux available from the CMAS Center Google Drive to avoid Error:403: Rate Limit Exceeded errors

  See README Data Download Instructions https://docs.google.com/document/d/1e7B94zFkbKygVWfrhGwEZL51jF4fGXGXZbvi6KzXYQ4


  
  Obtain the EQUATES Benchmark github repository using the command:


```
git clone -b main https://github.com/lizadams/EQUATES.git EQUATES
```
