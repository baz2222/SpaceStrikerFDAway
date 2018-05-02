:user_configuration
set AND_CERT_NAME="rsa-1024"
set AND_CERT_PASS=baz2222JuniorGames8377340
set AND_CERT_FILE=cert\SpaceStrikerFDAwayPKCS12.p12
set AND_ICONS=icons/android
set AND_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%AND_CERT_FILE%" -storepass %AND_CERT_PASS% -alias "%AND_CERT_NAME%"
set APP_XML=application.xml
set APP_DIR=bin
set FILE_OR_DIR=-C %APP_DIR% .
set APP_ID=air.com.juniorgames.spacestrikerfdaway.SpaceStrikerFDAway
set DIST_PATH=dist
set DIST_NAME=SpaceStrikerFDAway
set DEBUG_IP=127.0.0.1
:validation
%SystemRoot%\System32\find /C "<id>%APP_ID%</id>" "%APP_XML%" > NUL
echo setup app cemplete...
::pause