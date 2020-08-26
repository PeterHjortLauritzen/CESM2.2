load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin
;  vname = "Tgll_dbg"
;  vname = (/"OMEGA500","OMEGA500","OMEGA500","OMEGA500","OMEGA500"/)
  fnames =  lsArg ;systemfunc("ls "+lsArg)
  output_format = "pdf"

  wks = gsn_open_wks(output_format,"2d")
  fall = addfiles(fnames,"r")       ; Open netCDF files.	
  fcnt = dimsizes(fnames)
  print(fnames)

  lon = fall[0]->lon
  lat = fall[0]->lat
  nlon=dimsizes(lon)
  nlat=dimsizes(lat)

  pi = 3.14159265358979323846264338327D0
  deg2rad = pi/180.0
;  lat1d=lat1d*180.0/pi
;  lon1d=lon1d*180.0/pi


;******************************************************
; create plot
;******************************************************

;  gsn_define_colormap(wks,"BlAqGrYeOrReVi200")   ; choose colormap
;  gsn_define_colormap(wks,"NCV_roullet");
;  gsn_define_colormap(wks,"NCV_blue_red");NCV_jaisnd
;  gsn_define_colormap(wks,"NCV_banded");
;  gsn_define_colormap(wks,"BlAqGrWh2YeOrReVi22");
;  gsn_define_colormap(wks,"MPL_seismic");
  plot = new(fcnt,graphic) 
do k=0,3
  res                     = True         ; plot modifications desired
  res@gsnMaximize         = True         ; Maximize size of plot in frame
  res@gsnSpreadColors     = True         ; Use full colormap, but start
  res@gsnDraw             = False           ; don't draw
  res@gsnFrame            = False           ; don't advance frame
  res@cnFillOn            = True         ; Turn on contour fill
;  res@cnFillMode          = "AreaFill"   ; Style of fill. You can also
                                         ; use "CellFill" and "RasterFill"
  res@cnLinesOn           = False        ; Turn off contour lines
  res@cnLineLabelsOn      = False        ; Turn off contour line labels
  res@lbLabelAutoStride   = True         ; Clean up labelbar labels.
  res@lbLabelBarOn = True
;  res@mpOutlineOn     = False       ; No continents
;  res@cnFillMode="RasterFill"



;  res@mpMinLatF = -80.                   ; set the minimum latitude = -70.
;  res@mpMaxLatF = 80.                    ; set the maximum latitude = 70.

; res@mpMinLonF = -40.                    ; set the minimum latitude = -70.
;  res@mpMaxLonF = 40.


;  gsn_define_colormap(wks,"MPL_seismic");

    res@cnFillPalette             = "MPL_seismic"
;  gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
    res@cnLevelSelectionMode = "ManualLevels"
    res@cnMinLevelValF  = -0.2
    res@cnMaxLevelValF  = 0.2              
    res@cnLevelSpacingF = 0.01              
    res@mpCenterLonF = 180.0           ; Rotate the projection.


;  res@cnFillPalette  = "MPL_seismic"

    res@tiMainString        = titles(k)
    plotvar  = fall[k]->$vname(k)$(0,:,:)    ; Read some data; convert to 1D.i
    plot(k) = gsn_csm_contour_map_ce(wks,plotvar,res)
    delete(plotvar)
    delete(res)
  end do
;  delete(res@cnFillPalette)
;  res@cnFillPalette  = "precip2_17lev"
;  gsn_define_colormap(wks,"precip2_17lev");
  res = True
  res@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
  res@cnLevels    = (/0.2,0.5,1.0,2,3,4,5,6,7,8,9,10,12,14,17/)

  do k=4,5
    res@tiMainString        = titles(k)
    var   = fall[k]->PRECC(0,:,:)    ; Read some data; convert to 1D.i
    var2  = fall[k]->PRECL(0,:,:)    ; Read some data; convert to 1D.i
    var = var+var2
    var = var*1000*24*3600 ;convert from m/s to mm/day
    delete(var2)
    plot(k) = gsn_csm_contour_map_ce(wks,var,res)
    delete(var)
  end do
  delete(res@cnLevels)
;  gsn_define_colormap(wks,"MPL_seismic");
  k=6
  res@tiMainString        = titles(k)
  var   = fall[4]->PRECC(0,:,:)    ; Read some data; convert to 1D.i
  var2  = fall[4]->PRECL(0,:,:)    ; Read some data; convert to 1D.i
  var   = var+var2

  var3 = fall[5]->PRECC(0,:,:)    ; Read some data; convert to 1D.i
  var4 = fall[5]->PRECL(0,:,:)    ; Read some data; convert to 1D.i
  var3 = var3+var4  
  delete(var4)
  var = var-var3
  var = var*1000*24*3600 ;convert from m/s to mm/day
  res@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
  res@cnLevels    = (/-3,-2.75,-2.5,-2.25,-2,-1,1,2,2.25,2.5,2.75,3/)
;  res@cnLevelSelectionMode = "AutomaticLevels"
  plot(k) = gsn_csm_contour_map_ce(wks,var,res)
  delete(var)

  k=7
  res@tiMainString        = titles(k)
  var  = fall[2]->$vname(k)$(0,:,:)    ; Read some data; convert to 1D.i
  var2 = fall[3]->$vname(k)$(0,:,:)    ; Read some data; convert to 1D.i
  var  = var-var2
  delete(var2)
  res@cnLevelSelectionMode = "ManualLevels"
  res@cnMinLevelValF  = -0.2
  res@cnMaxLevelValF  = 0.2              
  res@cnLevelSpacingF = 0.01              
;  res@cnLevelSelectionMode = "AutomaticLevels"
  plot(k) = gsn_csm_contour_map_ce(wks,var,res)


;  do k=0,fcnt-1
;    print("plot "+k)
;;    lat1d = fall[k]->lat          ; Pull off lat/lon variable and
;;    lon1d = fall[k]->lon          ; convert both to 1D.
;
;    if (vname(k).eq."PRECT") then
;      var  = fall[k]->PRECC(0,:,:)    ; Read some data; convert to 1D.i
;      plotvar  = fall[k]->PRECC(0,:,:)    ; Read some data; convert to 1D.i      
;      var2  = fall[k]->PRECL(0,:,:)    ; Read some data; convert to 1D.i
;      var = var+var2
;      delete(var2)
;      if (k.eq.5) then
;        ref_ne30pg3 = fall[k]->PRECC(0,:,:)
;        ref_ne30pg3 = var 
;      end if
;      if (k.eq.5) then
;        ref_ne30pg3 = fall[k]->PRECC(0,:,:)
;        ref_ne30pg3 = var 
;      end if
;
;      if (k.eq.6) then
;        var = var-ref_ne30pg3
;      end if
;    else
;      if (k.eq.5) then
;        ref_ne30pg3 = fall[k]->PRECC(0,:,:)
;        ref_ne30pg3 = var 
;      end if
;      var  = fall[k]->$vname(k)$(0,:,:)    ; Read some data; convert to 1D.i
;      plotvar  = fall[k]->$vname(k)$(0,:,:)    ; Read some data; convert to 1D.i
;    end if
;
; 
;       
;    plotvar = var
;
;    res@tiMainString        = titles(k)
;
;    if (vname(k).eq."OMEGA500") then
;      res@cnLevelSelectionMode = "ManualLevels"
;      res@cnMinLevelValF  = -0.2
;      res@cnMaxLevelValF  = 0.2              
;      res@cnLevelSpacingF = 0.01              
;;      res@gsnRightString = "mm/day"
;    end if
;
;
;    if (vname(k).eq."PRECT") then
;      plotvar = 1000*24*3600*var ;convert from m/s to mm/day
;      if (k.eq.6) then
;;        res@cnLevelSelectionMode = "AutomaticLevels"
;        res@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
;        res@cnLevels    = (/-3,-2.75,-2.5,-2.25,-2,2,2.25,2.5,2.75,3/)
;      else
;        res@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
;        res@cnLevels    = (/0.2,0.5,1.0,2,3,4,5,6,7,8,9,10,12,14,17/)
;      end if 
;    end if
;

;;      res@cnLevelSelectionMode = "ManualLevels"
;;      res@cnMinLevelValF  = -20.0
;;      res@cnMaxLevelValF  = 120.0               
;;      res@cnLevelSpacingF = 10.0              
;
;
;    plot(k) = gsn_csm_contour_map_ce(wks,plotvar,res)
;    delete(var)
;    delete(plotvar)
;    delete(res@cnLevels)
;  end do
;
;************************************************
; create panel
;************************************************
  resP                  = True                   ; modify the panel plot
  resP@gsnFrame         = False                  ; don't advance panel plot
  resP@gsnPanelLabelBar = True                   ; add common colorbar
  resP@gsnMaximize         = True         ; Maximize size of plot in frame
;  resP@gsnPanelBottom   = 0.05
;  resP@txString   = "A common title"
  gsn_panel(wks,plot,(/6,2/),resP)               ; now draw as one plot


  txres               = True
;  txres@txFontHeightF = 0.015
;  gsn_text_ndc(wks,"Figure 1: A nifty panel plot",0.5,0.02,txres)
  frame(wks)
end
