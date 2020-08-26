#!/bin/tcsh
  echo "Plotting all files in in 'ls *.tke_200hPa.nc' in the current directory"
  ncl 'dir="'$PWD'"' 'ls_option=True' plot-tke.ncl
#  echo "Plotting all files in in 'ls *.tke_10hPa.nc' in the current directory"
#  ncl 'dir="'$PWD'"' 'ls_option=True' plot-tke.ncl

