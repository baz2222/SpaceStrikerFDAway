@echo off
cd %~dp0 & cd ..
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApp.bat
::target
goto desktop
::goto android
:desktop
::set SCREEN_SIZE=NexusOne
set SCREEN_SIZE=600x800:600x800
adl -screensize %SCREEN_SIZE% "%APP_XML%" "%APP_DIR%"
::adl "%APP_XML%" "%APP_DIR%"
goto end
:android
::set OPTIONS=-connect %DEBUG_IP%
set OPTIONS=
set PLATFORM=android
echo goto packaging...
set TARGET=apk-debug
::set TARGET=apk-captive-runtime
call bat\Packager.bat
adb devices
adb -d install -r "%OUTPUT%"
adb shell am start -n air.%APP_ID%/.AppEntry
echo runapp end ...
::pause
exit
:end
::pause