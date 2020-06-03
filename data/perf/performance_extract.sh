#!/bin/csh
#
# copy files and extract performance information
#
foreach cset (FW2000climo FWsc2000climo)
foreach res (ne30_ne30_mg17 ne30pg3_ne30pg3_mg17)
echo "#pecount   #SYPD" > data/${cset}_${res}_perf.dat
foreach pecount (450 900 1800 2700 5400)
  set caze=perf_${cset}_${res}_${pecount}
  foreach log (atm cesm cpl)
    cp /glade/scratch/$USER/$caze/run/$log.log* data/perf_${cset}_${res}_${pecount}.$log.log.gz
  end
  cp /glade/scratch/$USER/$caze/run/timing/model_timing_stats data/perf_${cset}_${res}_${pecount}.model_timing_stats
  cp /glade/scratch/$USER/$caze/run/timing/model_timing.00* data/perf_${cset}_${res}_${pecount}.model_timing.0000
  #
  # extract performance information
  #
  set log="cpl"
  gunzip data/perf_${cset}_${res}_${pecount}.$log.log.gz
  grep -a "simulated years" data/perf_${cset}_${res}_${pecount}.$log.log >> data/${cset}_${res}_perf.dat
  sed -i 's/(seq_mct_drv): ===============  # simulated years \/ cmp-day =/'$pecount'/g' data/${cset}_${res}_perf.dat
  sed -i 's/ ===============/ /g' data/${cset}_${res}_perf.dat
  gzip data/perf_${cset}_${res}_${pecount}.$log.log
end
end
end
