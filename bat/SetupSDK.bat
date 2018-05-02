cd %~dp0 & cd ..
:user_configuration
set FLEX_SDK=%FD_CUR_SDK%
set ANDROID_SDK=C:\Program Files (x86)\FlashDevelop\Tools\android
:validation
set PATH=%FLEX_SDK%\bin;%PATH%
set PATH=%PATH%;%ANDROID_SDK%\platform-tools
echo setup sdk complete...
::pause