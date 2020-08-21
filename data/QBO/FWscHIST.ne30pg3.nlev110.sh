#!/bin/tcsh
setenv PBS_ACCOUNT "P93300642"
#
# source code (assumed to be in /glade/u/home/$USER/src)
#
set src="CAM"
set res="ne30pg3_ne30pg3_mg17" #cslam
set nlev="110"
set steps="40"
set pecount="2700"
set cset="FWscHIST"
set stopoption="nmonths"
set jobq="regular"
set walltime="12:00:00"
set NTHRDS="1"

set caze=QBO_nlev${nlev}_${src}_${cset}_${res}_${pecount} #_NTHRDS${NTHRDS}_${steps}${stopoption}
/glade/u/home/$USER/src/$src/cime/scripts/create_newcase --case /glade/scratch/$USER/$caze --compset $cset --res $res  --q $jobq --walltime $walltime --pecount $pecount  --project $PBS_ACCOUNT --run-unsupported
cd /glade/scratch/$USER/$caze
./xmlchange STOP_OPTION=$stopoption,STOP_N=$steps
./xmlchange DOUT_S=FALSE
./xmlchange CAM_CONFIG_OPTS="-phys cam6 -age_of_air_trcs -chem waccm_sc_mam4 -cppdefs -Dwaccm_debug -nlev "$nlev""
./xmlquery CAM_CONFIG_OPTS
./xmlchange NTHRDS=$NTHRDS
./xmlchange TIMER_LEVEL=10
./xmlchange REST_N=3
./xmlchange REST_OPTION=nmonths
./xmlchange RESUBMIT=9
./xmlchange RUN_STARTDATE=1986-01-01
./case.setup


echo "se_statefreq       = 256"        >> user_nl_cam
echo "interpolate_output = .true.,.true.,.true."    >> user_nl_cam
echo "interpolate_nlat = 192,192,192"               >> user_nl_cam
echo "interpolate_nlon = 288,288,288"               >> user_nl_cam

echo "check_finidat_year_consistency = .false."  >> user_nl_clm
echo "qbo_use_forcing = .false."                    >> user_nl_cam

echo "empty_htapes       = .true."               >> user_nl_cam
echo "fexcl1 = ' '"               >> user_nl_cam
echo "fincl1 =   'U','V','Q','T','OMEGA','PS','PRECC','PRECL','UTGWORO','VTGWORO','BUTGWSPEC','BVTGWSPEC', "        >> user_nl_cam
echo "'UTGWSPEC','VTGWSPEC', 'TS', 'TAUX','TAUY','TAUBLJX','TAUBLJY','TAUGWX','TAUGWY','FLNT','FLNS','FSNS','FSNT',    "  >> user_nl_cam
echo "'LHFLX','SHFLX','TMQ','FLDS','FSDS','FSDSC','SWCF','LWCF','PRECSC','PRECSL','ZMDT',  'DTCOND','Z3', 'PSL'"           >> user_nl_cam
echo "'FT','CLDTOT','ABS_dPSdt','FU','FV','OMEGA500','OMEGA850'"                                              >> user_nl_cam
echo "nhtfrq = 0,0,0,0,0,0,0,0"                            >> user_nl_cam
echo "avgflag_pertape = 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A'"              >> user_nl_cam

qcmd -- ./case.build
./case.submit
