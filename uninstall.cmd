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
if errorLevel 1  echo *** ERROR: Please run this script as Administrator & goto :ERROR

%DOTNETPATH%\Regasm /u "%LOCALDIR%\IEspeedLibrary.dll"
if errorLevel 1 echo *** ERROR: Regasm not sucessful 

rmdir /s /q "%LOCALDIR%"
if exist "%LOCALDIR%" echo *** ERROR: removing files not sucessful & goto :ERROR

reg delete "HKLM\SOFTWARE\Classes\Wow6432Node\CLSID\{74627B42-6755-47CB-8402-AB0914774680}" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\AllowedControls" /v "{74627B42-6755-47CB-8402-AB0914774680}" /f

echo.
echo -------------------------------------------------------
echo SUCESSFULLY uninstalled IEspeed
echo -------------------------------------------------------
echo.

IF NOT "%1" == "/s"  pause
exit /b 0

:ERROR
IF NOT "%1" == "/s"  pause
exit /b 1
