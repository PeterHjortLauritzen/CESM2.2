#!/bin/tcsh
setenv PBS_ACCOUNT "P93300642"
#
# source code (assumed to be in /glade/u/home/$USER/src)
#
set src="CAM"
#
# choose dycore
#
set res="ne30pg3_ne30pg3_mg17" 
#set res="ne30_ne30_mg17" 
#set res="f09_f09_mg17"     
#
#
#
set cset="F2000climo"
set walltime="03:00:00"
set pecount="1800"
set NTHRDS="1"
set stopoption="nmonths"
set steps="3"
set caze=TKE_${src}_${cset}_${res}_${pecount}_${steps}${stopoption}
/glade/u/home/$USER/src/$src/cime/scripts/create_newcase --case /glade/scratch/$USER/$caze --compset $cset --res $res  --q regular --walltime $walltime --pecount $pecount  --project $PBS_ACCOUNT --run-unsupported
cd /glade/scratch/$USER/$caze
./xmlchange STOP_OPTION=$stopoption,STOP_N=$steps
./xmlchange DOUT_S=FALSE
./xmlchange NTHRDS=$NTHRDS
./case.setup

echo "fincl1            = 'PS','U','V'"                    >> user_nl_cam
echo "fincl2            = 'PS','U200','V200','U250','V250'">> user_nl_cam
echo "avgflag_pertape(1) = 'I'"                            >> user_nl_cam
echo "avgflag_pertape(2) = 'I'"                            >> user_nl_cam
echo "nhtfrq             = -6,-6                          ">> user_nl_cam
#echo "se_nu_div = 6.25E15                          ">> user_nl_cam
#echo "se_nu     = 1E15                          ">> user_nl_cam
#echo "se_hypervis_subcycle = 3">> user_nl_cam
if ($res == "ne30_ne30_mg17") then
  echo "se_statefreq       = 244"                          >> user_nl_cam
  echo "interpolate_output = .true.,.true.,.false.,.false.">> user_nl_cam
endif
if ($res == "ne30pg3_ne30pg3_mg17") then
  echo "se_statefreq       = 244"                          >> user_nl_cam
  echo "interpolate_output = .true.,.true.,.false.,.false.">> user_nl_cam
endif

qcmd -- ./case.build
./case.submit
