#!/bin/csh
set res="ne30pg3_ne30pg3_mg17"      #cslam
#set res="ne30_ne30_mg17"
set cset="FW2000climo"
#set cset="FWsc2000climo"
foreach pecount (450 900 1800 2700 5400)
  source /glade/u/home/pel/git-scripts/run-cam/collection/performance.sh
end

