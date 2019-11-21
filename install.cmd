@echo off
echo -------------------------------------------------------
echo  Installing IEspeed ActiveX control
echo -------------------------------------------------------
echo.
set STAGEDIR=%~dp0
set SOURCEDIR=%STAGEDIR%\Release
set LOCALDIR=%PROGRAMFILES(x86)%\IEspeed
set DOTNETPATH=%SYSTEMROOT%\Microsoft.NET\Framework\v4.0.30319\

echo SOURCE DIR: %SOURCEDIR%
echo STAGE DIR: %STAGEDIR%
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

robocopy /R:0 /W:0 /NFL /NDL /MIR "%SOURCEDIR%" "%LOCALDIR%" /XD ".svn"

if errorLevel 8 (
    echo.
    echo *** ERROR: Copying files not sucessful
    echo.
	pause
	exit
)

%DOTNETPATH%\Regasm "%LOCALDIR%\IEspeedLibrary.dll" /tlb /codebase

regedit /s "%STAGEDIR%\iespeed_mark_as_safe.reg"

if errorLevel 1 (
    echo.
    echo *** ERROR: Importing registry entries not successful
    echo.
	pause
	exit
)

echo.
echo -------------------------------------------------------
echo SUCESSFULLY installed IEspeed
echo -------------------------------------------------------
echo.

pause

