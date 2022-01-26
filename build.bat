@echo off
del FS22_AdjustableCamera.zip
"%programfiles%\7-Zip\7z.exe" a -tzip FS22_AdjustableCamera.zip modDesc.xml icon.dds *.lua
pause