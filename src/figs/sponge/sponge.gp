#set term pdfcairo font "Times-New-Roman,12"
#set output "sponge.pdf"
#set terminal postscript eps size 3.5,2.62 enhanced color font 'Helvetica,20' linewidth 2
set terminal postscript eps  enhanced color font 'Helvetica,20' linewidth 2
set output "sponge.eps"

#
# CAM5 top layers
#
#ptop =  2.2552395239472389E+02
#set output "cam.pdf"
#
# WACCM
#
#ptop=0.0005
ptop=0.00049485
#ptop=1.4315


fac(x) =  8.0*(1.0+ tanh(1.0*log(ptop/x)))
fac(x) =  0.5*(1.0+ tanh(1.0*log(100.0/x)))
#fac(x) =  0.5*(1.0+ tanh(1.0*log(20.0/x)))
#fac(x) =  30000.0*0.5*(1.0+ tanh(1.0*log(0.6/x)))
fac3(x) =  0.5*(1.0+tanh(1.0*log(1000.0/x))) #nu_div version 1
fac4(x) =  0.5*(1.0+ tanh(1.0*log(0.01/x)))
#fac3(x) =  0.5*(1.0+tanh(1.0*log(1.0/x))) #nu_div version 2
fac2(x) =  0.5*(1.0+tanh(1.0*log(1.0/x))) #nu
#fac(x) =  0.5*(1.0+ tanh(2.0*log(ptop/x)))

set grid
set title "Sponge layer damping"
set xlabel  "Equivalent Laplacian diffusion coefficient [10^5 m^2/s^2]"
set ylabel "height [km]"
#set xtics ('-2{/Symbol p}' -2*pi,'-{/Symbol p}' -pi,0, \
#    '{/Symbol p}' pi,'2{/Symbol p}' 2*pi)
set key center right width 2 height 1.5 box
plot "waccm-70-sponge.dat" u ($5/1E5):($3/1E3) w lp ps 1.5 pt 7 lt 7 lw 4 title "WACCM6-SE",\
     "cam-32-sponge.dat"   u ($5/1E5):($3/1E3) w lp ps 1.5 pt 6 lt 6 lw 2 title "CAM6-SE"
# test