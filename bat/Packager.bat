@echo off
set CERT_FILE=%AND_CERT_FILE%
set SIGNING_OPTIONS=%AND_SIGNING_OPTIONS%
set ICONS=%AND_ICONS%
set DIST_EXT=apk
set FILE_OR_DIR=%FILE_OR_DIR% -C "%ICONS%" .
if not exist "%DIST_PATH%" md "%DIST_PATH%"
set OUTPUT=%DIST_PATH%\%DIST_NAME%.%DIST_EXT%
echo calling adt...
call adt -package -target %TARGET% %OPTIONS% %SIGNING_OPTIONS% "%OUTPUT%" "%APP_XML%" %FILE_OR_DIR%
echo package end
::pause