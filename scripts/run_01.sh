./FastFlow Zhou /mnt/i/taudem/data-dem/merit90_china_flowdir.tif china_flowaccu.tif



# convert flowdir from arcgis style to taudem
d8_convert /mnt/o/ChinaBasins/dem_raw/Tarim/flowdir flowdir.tif
flowbasin /mnt/o/ChinaBasins/dem_raw/Tarim/flowdir_taudem.tif /mnt/o/ChinaBasins/dem_raw/Tarim/chinaRunoff_stationInfo_Tarim_sp8.shp Tarim
