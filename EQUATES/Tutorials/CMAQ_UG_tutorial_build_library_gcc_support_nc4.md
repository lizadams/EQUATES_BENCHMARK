##Following these instructions
##https://www.unidata.ucar.edu/software/netcdf/documentation/NUG/getting_and_building_netcdf.html
##Building with netCDF-4 and the Remote Data Client
##The usual way of building netCDF requires the HDF5, zlib, and curl libraries. 
##Versions required are at least HDF5 1.8.9, zlib 1.2.5, and curl 7.18.0 or later.

set install directory
set INSTALL_DIR = /proj/ie/proj/CMAS/EQUATES/LIBRARIES/

1. If your compute server uses modules use the following command to see what packages are available

```
module avail
```
2. Load module environment for a compiler (Intel|GCC|PGI) and mpi package corresponding to that compiler (e.g. openmpi).

```
module load gcc9.1.0
module load openmpi_4.0.1/gcc_9.1.0
```


## Install zlib

1. cd $INSTALL_DIR

2. wget http://www.zlib.net/zlib-1.2.11.tar.gz

3. tar -xzvf zlib-1.2.11.tar.gz

4. cd zlib-1.2.11

5. ./configure ; make test

6. mkdir ${INSTALL_DIR}/zlib-1.2.11_gcc9.1.0

7. make install prefix=${INSTALL_DIR}/zlib-1.2.11_gcc9.1.0

## Install curl (check first to determine if it is already installed)

1. check to see if which is installed using

2. curl --version


###IF it is not installed use the following steps to install it.

3. wget https://curl.se/download/curl-7.79.0.tar.gz

4. tar -xzvf curl-7.79.0.tar.gz

5. ./configure --without-ssl --prefix=${INSTALL_DIR}/curl-7.79.0-gcc9.1.0

6. make

7. make install

## Install HDF5

1. cd $INSTALL_DIR

2. wget wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.7/src/hdf5-1.10.7.tar.gz

3. tar -xzvf hdf5-1.10.7.tar.gz

4. mkdir ${INSTALL_DIR}/hdf5-1.10-7-gcc9.1.0

5. cd hdf5-1.10.7

6. ./configure --prefix=${INSTALL_DIR}/hdf5-1.10-7-gcc9.1.0 --with-zlib=${INSTALL_DIR}/zlib-1.2.11_gcc9.1.0/include,${INSTALL_DIR}/zlib-1.2.11_gcc9.1.0/lib --enable-hl

7. make

8. make check   # run test suite

9. make install # install

10. make check-install # verify installation

## Install netCDF-C


1. cd ${INSTALL_DIR}

2. Download netCDF-C from the following website https://www.unidata.ucar.edu/downloads/netcdf/index.jsp

```
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-c-4.7.0.tar.gz
```

3. Untar the netCDF-C tar.gz file

```
tar -xzvf netcdf-c-4.7.0.tar.gz
```

4. Change directories into the extracted directory
```
cd netcdf-c-4.7.0
```

5. Review the installation instructions for netcdf-c-4.7.0 for building Classic netCDF

```
more INSTALL.md
```

6. Create a target installation directory that includes the loaded module environment name

```
mkdir ${INSTALL_DIR}/netcdf-c-4.7.0-gcc9.1.0
```


7. Run the configure --help command to see what settings can be used for the build.
```
./configure --help
```

11. Set the Compiler environment variables

Make sure these compilers can be found.
```
which gfortran
which gcc
which g++
```
If they are found, proceed to set the environment variables.
The paths will be dependent on your compute environment
If they are not found, reload your module (see above), or ask your system administrator for the paths to a compiler
```

setenv FC gfortran
setenv CC gcc
setenv CXX g++
```

12. Run the configure command

```
./configure --prefix=$${INSTALL_DIR}/netcdf-c-4.7.0-gcc9.1.0
```

13. Check that the configure command worked correctly, then run the install command

```
make check install
```

14. Verify that the following message is obtained

```
| Congratulations! You have successfully installed netCDF!    |
```

15. Change directories to one level up from your current directory
```
cd ..
```

## Install netCDF-Fortran

1. Download netCDF-Fortran from the following website https://www.unidata.ucar.edu/downloads/netcdf/index.jsp

```
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.4.5.tar.gz 
```

2. Untar the tar.gz file

```
tar -xzvf netcdf-fortran-4.4.5.tar.gz
```

3. Change directories to netcdf-fortran-4.4.5

```
cd netcdf-fortran-4.4.5
```

4. Make an install directory that matches the name of your loaded module environment

```
mkdir ../netcdf-fortran-4.4.5-gcc9.1.0
```

5. Review the installation document http://www.unidata.ucar.edu/software/netcdf/docs/building_netcdf_fortran.html

6. Set the environment variable NCDIR to specify the install directory

```
setenv NCDIR $cwd/../netcdf-c-4.7.0-gcc9.1.0
```

7. Set the CC environment variable to use the gcc and gfortran compilers

```
which gfortran
which gcc
which g++

setenv FC gfortran
setenv CC gcc
setenv CXX g++
```

8. Set your LD_LIBRARY_PATH to include the netcdf-C library path for netCDF build

```
setenv NCDIR $cwd/../netcdf-c-4.7.0-gcc9.1.0
setenv LD_LIBRARY_PATH ${NCDIR}/lib:${LD_LIBRARY_PATH}
```

9. Check your LD_LIBRARY_PATH

```
echo $LD_LIBRARY_PATH
```

10. Set the install directory for netCDF fortran

```
setenv NFDIR $cwd/../netcdf-fortran-4.4.5-gcc9.1.0

setenv CPPFLAGS -I${NCDIR}/include
setenv LDFLAGS -L${NCDIR}/lib
```

11. Run the configure command

```
./configure --prefix=${NFDIR}
```

12. Run the make check command

```
make check
```

Output if successful:

```
Testsuite summary for netCDF-Fortran 4.4.5
==========================================
# TOTAL: 6
# PASS:  6
```

13. Run the make install command

```
make install
```

Output successful if you see Libraries have been installed in the install directory

```
ls $cwd/../netcdf-fortran-4.4.5-gcc9.1.0
```

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the '-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the 'LD_LIBRARY_PATH' environment variable
     during execution
   - add LIBDIR to the 'LD_RUN_PATH' environment variable
     during linking
   - use the '-Wl,-rpath -Wl,LIBDIR' linker flag
   - have your system administrator add LIBDIR to '/etc/ld.so.conf'


14. set your LD_LIBRARY_PATH to include the netcdf-Fortran library path for netCDF build

```
setenv NFDIR $cwd/../netcdf-fortran-4.4.5-gcc9.1.0
setenv LD_LIBRARY_PATH ${NFDIR}/lib:${LD_LIBRARY_PATH}
```
(may need to add the NCDIR and NFDIR to .cshrc)

## Install I/O API
Note
The complete I/O API installation guide can be found at either of the following:

https://www.cmascenter.org/ioapi/documentation/all_versions/html/AVAIL.html

or

https://cjcoats.github.io/ioapi/AVAIL.html

1. Change directories to one level up from your current location
```
cd ../
```

2. Download I/O API

```
git clone https://github.com/cjcoats/ioapi-3.2
```

3. change directories to the ioapi-3.2 directory
```
cd ioapi-3.2
```

2. Change branches to 20200828 for a tagged stable version

```
git checkout -b 20200828
```

3. Change directories to the ioapi directory

```
cd ioapi
```

4. copy the Makefile.nocpl file to create a Makefile

```
cp Makefile.nocpl Makefile
```

5. Set the BIN environment variable to include the module that will be used to compile CMAQ
This will help future users identify what compiler version is compatible with this library.

```
setenv BIN Linux2_x86_64gfort_openmpi_4.0.1_gcc_9.1.0
```

6. Copy an existing Makeinclude file to have this BIN name at the end

```
cp Makeinclude.Linux2_x86_64gfort Makeinclude.Linux2_x86_64gfort_openmpi_4.0.1_gcc_9.1.0
```

7. Edit the Makeinclude.Linux2_x86_64gfort_openmpi_4.0.1_gcc_9.1.0 to comment out OMPFLAG and OMPLIBS 
settings.  This will remove the need to link the shared memory OPENMP libraries when compiling CMAQ and WRF-CMAQ.

```
#OMPFLAGS  = -fopenmp
#OMPLIBS   =  -fopenmp
```

8. Create a BIN directory where the library and m3tools executables will be installed

```
mkdir ../$BIN
```

9. Link the BIN directory to a the gfort BIN directory - this step is needed for WRF-CMAQ.

```
cd ../
ln -s Linux2_x86_64gfort_openmpi_4.0.1_gcc_9.1.0 Linux2_x86_64gfort
```

10. Set the HOME environment variable to be your LIBRARY install directory and run the make command to compile and link the ioapi library

```
cd ioapi
make 'HOME=[your_install_path]/LIBRARIES' |& tee make.log
```

11. Change directories to the $BIN dir and verify that both the libioapi.a library was successfully built

```
cd ../$BIN
ls -lrt libioapi.a
```

12. If you need to do a make clean, to rebuild the I/O API Library, specify the HOME directory at the command line as follows

```
cd ../ioapi
make 'HOME=[your_install_path]/LIBRARIES' clean 
```

12. Change directories to the m3tools directory
```
cd ../m3tools
```

13. Copy the Makefile.nocpl to create a Makefile
```
cp Makefile.nocpl Makefile
```

14. Edit line 65 of the Makefile to use the NCDIR and NFDIR environment variables that you have set in the above steps to locate the netcdf C and netcdf Fortran libraries

```
 LIBS = -L${OBJDIR} -lioapi -L${NFDIR}/lib -lnetcdff -L${NCDIR}/lib -lnetcdf $(OMPLIBS) $(ARCHLIB) $(ARCHLIBS)
 ```

15. Run make to compile the m3tools
```
make |& tee make.log
```
16. Check to see that the m3tools have been installed successfully
```
cd ../$BIN
ls -rlt m3xtract
```

17. After successfull completion of this tutorial, the user is now ready to proceed to the [CMAQ Installation & Benchmarking Tutorial](./CMAQ_UG_tutorial_benchmark.md)

