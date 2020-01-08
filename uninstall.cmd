@echo off
echo -------------------------------------------------------
echo  Uninstalling IEspeed ActiveX control
echo -------------------------------------------------------
echo.
set LOCALDIR=%PROGRAMFILES(x86)%\IEspeed
set DOTNETPATH=%SYSTEMROOT%\Microsoft.NET\Framework\v4.0.30319\

echo LOCAL DIR: %LOCALDIR%
echo.

rem check Admin Permissions
net session >nul 2>&1
if errorLevel 1  (
    echo *** ERROR: Please run this script as Administrator
	echo.
	pause
	exit
)

%DOTNETPATH%\Regasm /u "%LOCALDIR%\IEspeedLibrary.dll"

rmdir /s /q "%LOCALDIR%"

if errorLevel 1 (
    echo.
    echo *** ERROR: Removing directory not successful
    echo.
	pause
	exit
)

echo.
echo -------------------------------------------------------
echo SUCESSFULLY uninstalled IEspeed
echo -------------------------------------------------------
echo.

pause
