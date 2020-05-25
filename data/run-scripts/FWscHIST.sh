#!/bin/tcsh
#setenv PBS_ACCOUNT "P03010039"
#setenv PBS_ACCOUNT "P19010000" #ACOM account
#setenv PBS_ACCOUNT "P93300607" #ACOM account
setenv PBS_ACCOUNT "P93300642"
#
# source code (assumed to be in /glade/u/home/$USER/src)
#

set src="cam_pel_development_trunk"
#set src="se_dev"
#
# run with CSLAM or without
#
set res="ne30pg3_ne30pg3_mg17" #cslam
set nlev="70"
set steps="10"
#set nlev="110"
#set steps="4"
set stopoption="nyears"
set cset="HIST_CAM60%WCSC_CLM50%BGC-CROP_CICE%PRES_DOCN%DOM_MOSART_CISM2%NOEVOLVE_SWAV"
#set walltime="00:10:00"
set pecount="5400"
set jobq="economy"
set walltime="12:00:00"
set NTHRDS="1"

set caze=cecille_nlev${nlev}_${src}_FWscHIST_${res}_${pecount} #_NTHRDS${NTHRDS}_${steps}${stopoption}
/glade/u/home/$USER/src/$src/cime/scripts/create_newcase --case /glade/scratch/$USER/$caze --compset $cset --res $res  --q $jobq --walltime $walltime --pecount $pecount  --project $PBS_ACCOUNT --run-unsupported
cd /glade/scratch/$USER/$caze
./xmlchange STOP_OPTION=$stopoption,STOP_N=$steps
./xmlchange DOUT_S=FALSE
#./xmlchange --append CAM_CONFIG_OPTS="-cppdefs -Dwaccm_debug"
#./xmlchange CAM_CONFIG_OPTS="-phys cam6 -age_of_air_trcs -chem waccm_sc_mam4 -usr_mech_infile /glade/work/mmills/case/f.e21.FWsc2000climo.ne30pg3_ne30pg3_mg17.c20190831/chem_mech.in -cppdefs -Dwaccm_debug -nlev "$nlev""
./xmlchange CAM_CONFIG_OPTS="-phys cam6 -age_of_air_trcs -chem waccm_sc_mam4  -nlev "$nlev" -cppdefs -Dwaccm_debug"
#
./xmlquery CAM_CONFIG_OPTS
./xmlchange NTHRDS=$NTHRDS
./xmlchange TIMER_LEVEL=10
./xmlchange REST_N=4
./xmlchange REST_OPTION=nmonths
./xmlchange RUN_STARTDATE=1986-01-01
./xmlchange RESUBMIT=5
./xmlchange CAM_CONFIG_OPTS=' -pcols 9' --append
./case.setup

echo "inithist = 'YEARLY'" >> user_nl_cam
echo "se_statefreq       = 256"        >> user_nl_cam
echo "interpolate_output = .true.,.true.,.true."    >> user_nl_cam
echo "interpolate_nlat = 192,192,192"               >> user_nl_cam
echo "interpolate_nlon = 288,288,288"               >> user_nl_cam
echo "                        " >> user_nl_cam
echo "fincl1 =   'U','V','Q','T','PSL','OMEGA','PS','PRECC','PRECL','UTGWORO','VTGWORO','BUTGWSPEC','BVTGWSPEC',       " >> user_nl_cam
echo "'UTGWSPEC','VTGWSPEC', 'TS', 'TAUX','TAUY','TAUBLJX','TAUBLJY','TAUGWX','TAUGWY','FLNT','FLNS','FSNS','FSNT',    " >> user_nl_cam
echo "'LHFLX','SHFLX','TMQ','FLDS','FSDS','FSDSC','SWCF','LWCF','PRECSC','PRECSL','ZMDT',  'DTCOND','Z3', 'PSL',       " >> user_nl_cam
echo "'OMEGA500','OMEGA850','ABS_dPSdt','nu_kmvis','nu_kmcnd'" >> user_nl_cam

#fincl2 = 'TROP_T', 'TROP_P', 'Q', 'T','U850','V850','U200','V200','PRECT','OMEGA500','FLUT','Z500','T500','PS'   " >> user_nl_cam
echo "nhtfrq = 0,0,0,0,0,0,0,0"                                              >> user_nl_cam
echo "avgflag_pertape = 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A'"              >> user_nl_cam
echo "                                            " >> user_nl_cam

echo "                                            " >> user_nl_cam
echo "qbo_use_forcing = .false."                    >> user_nl_cam
echo "                                            " >> user_nl_cam

echo "check_finidat_year_consistency = .false." >> user_nl_clm

#echo "se_vert_remap_tracer_alg      = -9"  >> user_nl_clm

echo "fsurdat = '/glade/work/aherring/grids/uniform-res/ne30np4.pg3/clm_surfdata_5_0/surfdata_ne30np4.pg3_hist_78pfts_CMIP6_simyr1850_c200426.nc'">>user_nl_clm
echo "flanduse_timeseries = '/glade/scratch/aherring/ctsm_release-clm5.0.30/tools/mksurfdata_map/cam-se/landuse.timeseries_ne30np4.pg3_hist_78pfts_CMIP6_simyr1850-2015_c200426.nc'">>user_nl_clm


#echo "        'E90 -> /glade/p/cesmdata/cseg/inputdata/atm/cam/chem/emis/CMIP6_emissions_1750_2015/emissions_E90global_surface_1750-2100_0.9x1.25_c20170322.nc'" >> user_nl_cam
#./xmlchange RUN_REFCASE=opt-se-cslam-new_FWsc2000climo_ne30pg3_ne30pg3_mg17_2700_NTHRDS1_12nmonths
#./xmlchange RUN_REFDATE=0001-12-30
#./xmlchange RUN_STARTDATE=0001-12-30
#cp /glade/scratch/pel/opt-se-cslam-new_FWsc2000climo_ne30pg3_ne30pg3_mg17_2700_NTHRDS1_12nmonths/run/*.r*.0001-12-30-00000.nc run/




#./xmlchange RUN_REFCASE=f.e21.FW2000climo.ne30pg3_ne30pg3_mg17.cam_trunk.outputFV1deg.c190411,RUN_REFDATE=0017-01-01,GET_REFCASE=TRUE,RUN_TYPE=hybrid

#echo "use_init_interp = .true." >> user_nl_clm

qcmd -- ./case.build
#./case.submit
