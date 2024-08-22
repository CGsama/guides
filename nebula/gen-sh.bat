@echo off
setlocal EnableExtensions EnableDelayedExpansion
REM set "Counter=1"
for /F "delims=" %%I in ('dir /A-D /B node*.crt 2^>nul') do (
    type "setup.txt" > "%%~nI.sh"
    echo.>>"%%~nI.sh"

    set lineq="sudo tee /etc/nebula/ca.crt > /dev/null <<EOT"
    FOR /F "delims=" %%L IN (!lineq!) DO SET line=%%L
    echo !line!>> "%%~nI.sh"
    type "ca.crt" >> "%%~nI.sh"
    echo EOT>>"%%~nI.sh"

    set lineq="sudo tee /etc/nebula/%%~nI.crt > /dev/null <<EOT"
    FOR /F "delims=" %%L IN (!lineq!) DO SET line=%%L
    echo !line!>> "%%~nI.sh"
    type "%%~fI" >> "%%~nI.sh"
    echo EOT>>"%%~nI.sh"
)
for /F "delims=" %%I in ('dir /A-D /B node*.key 2^>nul') do (
    set lineq="sudo tee /etc/nebula/%%~nI.key > /dev/null <<EOT"
    FOR /F "delims=" %%L IN (!lineq!) DO SET line=%%L
    echo !line!>> "%%~nI.sh"
    type "%%~fI" >> "%%~nI.sh"
    echo EOT>>"%%~nI.sh"

    set lineq="sed -i 's/\/etc\/nebula\/host/\/etc\/nebula\/%%~nI/g' /etc/nebula/config.yml"
    FOR /F "delims=" %%L IN (!lineq!) DO SET line=%%L
    echo !line!>> "%%~nI.sh"

    echo sudo systemctl daemon-reload>> "%%~nI.sh"
    echo sudo systemctl enable nebula>> "%%~nI.sh"
    echo history -c>> "%%~nI.sh"
    echo sudo systemctl restart nebula>> "%%~nI.sh"
    echo ping 10.36.53.1>> "%%~nI.sh"

)
endlocal
pause