#!/bin/tcsh
set n = 1
set vname = "$argv[$n]"
#
# set paths depending on machine
#
if (`hostname` == "hobart.cgd.ucar.edu") then
  echo "You are on Hobart"
  set data_dir = "/scratch/cluster/$USER/"
  setenv ncl_dir  "/home/$USER/git-scripts/ncl_scripts"
  set line_colors = "(/"\"red\"","\"blue\"","\"sienna1\"","\"deepskyblue\""/)"  
  echo "NCL directory is"$ncl_dir
endif
if (`hostname` == "izumi.unified.ucar.edu") then
  echo "You are on Izumi"
  set data_dir = "/scratch/cluster/$USER/"
  setenv ncl_dir  "/home/$USER/git-scripts/ncl_scripts"
  echo "NCL directory is"$ncl_dir
endif
set line_colors = "(/"\"red\"","\"blue\"","\"sienna1\"","\"deepskyblue\""/)"


#set fileA  = "nu_top_0.25_trunk_FHS94_CAM_ne30_ne30_mg17_480_NTHRDS1_1200ndays.ave.h0.nc"
#set titleA = "nu_top=0.25e5"
#set fileB = "nu_top_0.5e5trunk_FHS94_CAM_ne30_ne30_mg17_480_NTHRDS1_1200ndays.ave.h0.nc"
#set titleB = "nu_top=0.5e5"
#set fileC = "nu_top_1.0e5_trunk_FHS94_CAM_ne30_ne30_mg17_480_NTHRDS1_1200ndays.ave.h0.nc"
#set titleC = "nu_top=1.0e5"
#set fileD = "nu_top_2.5e5_hypervisOnPlevsFalse_trunk_FHS94_CAM_ne30_ne30_mg17_480_NTHRDS1_1200ndays.ave.h0.nc"
#set titleD = "nu_top=2.5e5"
#set fileE = "nu_top_5.0e5_trunk_FHS94_CAM_ne30_ne30_mg17_480_NTHRDS1_1200ndays.ave.h0.nc"
#set titleE = "nu_top=5.0e5"
#set fileF = "fv.ave.h0.nc"
#set titleF = "FV"

#set file = "(/"\"$fileA\"","\"$fileB\"","\"$fileC\"","\"$fileD\"","\"$fileE\"","\"$fileF\""/)"
#set titles = "(/"\"$titleA\"","\"$titleB\"","\"$titleC\"","\"$titleD\"","\"$titleE\"","\"$titleF\""/)"

set fileC  = "../ne30_trunk/ne30_trunk.ave.nc"
set titleC = "ne30"
set fileA  = "../fv09/fv09.ave.nc"
set titleA = "fv"
set fileB  = "../ne30_PGF_Tref0_psref0/ne30_PGF_Tref0_psref0.ave.nc"
set titleB = "ne30_CAM5"
set fileD  = "../ne30_PGF/ne30_PGF.ave.nc"
set titleD = "ne30_CAM5+Exner"
set fileE  = "../ne30pg3_trunk/ne30pg3_trunk.ave.nc"
set titleE = "ne30pg3"
set fileF  = "../ne30pg3_trunk/ne30pg3_trunk.ave.nc"
set titleF = "ne30pg3"

#set fileC  = "../fv09-high-order-top/fv09-high-order-top.ave.nc"
#set titleC = "FVhigh-order-top"

set file   = "(/"\"../ne30_CESM1.5/ne30_CESM1.5.ave.h0.nc\"","\"../ne30_Tref_psref0/ne30_Tref_psref0.ave.h0.nc\"","\"../ne30_CESM1.5/ne30_CESM1.5.F2000climo.ave.h0.nc\""/)"
set titles = "(/"\"ne30,old-PGF,T~S~ref~N~=0,dp~S~ref~N~=0,~F33~n~F~=1E15m~S~4~N~/s~S~2~N~,~F33~n~F~~B~div~N~=6.25E15m~S~4~N~/s~S~2~N~\"","\"ne30,new-PGF,T~S~ref~N~=0,dp~S~ref~N~=0,~F33~n~F~=0.5E15m~S~4~N~/s~S~2~N~,~F33~n~F~~B~div~N~=2.5E15m~S~4~N~/s~S~2~N~\"","\"F200climo\""/)" 

#../fv09/fv09.ave.h0.nc\"","\"../ne30/ne30.ave.h0.nc\"","\"../ne30_oldPGF/ne30_oldPGF.ave.h0.nc\"","\"../fv09-aamfix/fv09-aamfix.ave.h0.nc\"","\"../ne30_oldPGF_Tref0_psref0/ne30_oldPGF_Tref0_psref0.ave.h0.nc\"","\"../ne30_Tref_psref0/ne30_Tref_psref0.ave.h0.nc\"","\"../ne30pg3/ne30pg3.ave.h0.nc\"","\"../ne30_all_nu_same/ne30_all_nu_same.ave.h0.nc\"","\"../ne30_psref0/ne30_psref0.ave.h0.nc\"","\"../ne30_all_nu_same_oldPGF_Tref0_psref0/ne30_all_nu_same_oldPGF_Tref0_psref0.ave.h0.nc\"","\"../ne30_CESM1.5/ne30_CESM1.5.ave.h0.nc\""/)"
#set titles = "(/"\"fv09\"","\"ne30\"","\"ne30_oldPGF\"","\"fv09-aamfix\"","\"ne30_oldPGF_Tref0_psref0\"","\"ne30_Tref_psref0\"","\"ne30pg3\"","\"ne30_all_nu_same\"","\"ne30_psref0\"","\"ne30_all_nu_same_oldPGF_Tref0_psref0\"","\"CESM1.5\""/)"
#ne30_CESM1.5/ne30_CESM1.5.F2000climo.ave.h0.nc
#set file = "(/"\"../fv09/fv09.ave.h0.nc\"","\"../ne30/ne30.ave.h0.nc\"","\"../ne30_oldPGF/ne30_oldPGF.ave.h0.nc\"","\"../fv09-aamfix/fv09-aamfix.ave.h0.nc\"","\"../ne30_oldPGF_Tref0_psref0/ne30_oldPGF_Tref0_psref0.ave.h0.nc\"","\"../ne30_Tref_psref0/ne30_Tref_psref0.ave.h0.nc\"","\"../ne30pg3/ne30pg3.ave.h0.nc\"","\"../ne30_all_nu_same/ne30_all_nu_same.ave.h0.nc\"","\"../ne30_psref0/ne30_psref0.ave.h0.nc\"","\"../ne30_all_nu_same_oldPGF_Tref0_psref0/ne30_all_nu_same_oldPGF_Tref0_psref0.ave.h0.nc\"","\"../ne30_CESM1.5/ne30_CESM1.5.ave.h0.nc\""/)"
#set titles = "(/"\"fv09\"","\"ne30\"","\"ne30_oldPGF\"","\"fv09-aamfix\"","\"ne30_oldPGF_Tref0_psref0\"","\"ne30_Tref_psref0\"","\"ne30pg3\"","\"ne30_all_nu_same\"","\"ne30_psref0\"","\"ne30_all_nu_same_oldPGF_Tref0_psref0\"","\"CESM1.5\""/)"

set PanelTitle="FHS94, 1000 day average"

ncl 'vname="'$vname'"' 'vertical_height = True' 'lsArg='$file'' 'titles='$titles'' 'plot_lat_section=True' 'plot_lat_section_min=-90' 'plot_lat_section_max=90' 'coslat= False' 'diff=False' 'line_colors="$line_colors"' 'lsinx = True' 'PanelTitle="'"$PanelTitle"'"' < 2d_latlon_PK02-F2000climo.ncl

unset file
unset titles
unset fileA
unset fileB
unset fileC
unset fileD
unset fileE
unset fileF
unset titleA
unset titleB
unset titleC
unset titleD
unset titleE
unset titleF
