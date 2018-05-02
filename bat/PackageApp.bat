@echo off
cd %~dp0 & cd ..
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApp.bat
set PLATFORM=android
set OPTIONS=
set TARGET=apk-captive-runtime
echo packaging starts...
::pause
call bat\Packager.bat
adb devices
adb -d install -r "%OUTPUT%"
::pause
