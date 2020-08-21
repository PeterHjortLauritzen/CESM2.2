load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin
;  vname = "Tgll_dbg"
  fnames =  lsArg ;systemfunc("ls "+lsArg)
  output_format = "pdf"

  wks = gsn_open_wks(output_format,"2d_"+vname)
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
  gsn_define_colormap(wks,"MPL_seismic");

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
  res@lbLabelBarOn = False
;  res@mpOutlineOn     = False       ; No continents
;  res@cnFillMode="RasterFill"



;  res@mpMinLatF = -80.                   ; set the minimum latitude = -70.
;  res@mpMaxLatF = 80.                    ; set the maximum latitude = 70.

; res@mpMinLonF = -40.                    ; set the minimum latitude = -70.
;  res@mpMaxLonF = 40.

  plot = new(fcnt,graphic) 
  do k=0,fcnt-1
    print("plot "+k)
;    lat1d = fall[k]->lat          ; Pull off lat/lon variable and
;    lon1d = fall[k]->lon          ; convert both to 1D.

    var  = fall[k]->$vname$(0,:,:)    ; Read some data; convert to 1D.i
    plotvar  = fall[k]->$vname$(0,:,:)    ; Read some data; convert to 1D.i
    if (k.eq.0) then
      ref = 0.0;var
      plotvar = var
    else
      plotvar = var-ref
    end if

    res@tiMainString        = titles(k)

    if (vname.eq."OMEGA500") then
      res@cnLevelSelectionMode = "ManualLevels"
      res@cnMinLevelValF  = -0.2
      res@cnMaxLevelValF  = 0.2              
      res@cnLevelSpacingF = 0.01              
;      res@gsnRightString = "mm/day"
    end if
    res@mpCenterLonF = 180.0           ; Rotate the projection.

;      res@cnLevelSelectionMode = "ManualLevels"
;      res@cnMinLevelValF  = -20.0
;      res@cnMaxLevelValF  = 120.0               
;      res@cnLevelSpacingF = 10.0              


    plot(k) = gsn_csm_contour_map_ce(wks,plotvar,res)
    delete(var)
    delete(plotvar)
  end do

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
