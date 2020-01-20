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
if errorLevel 1  echo *** ERROR: Please run this script as Administrator & goto :ERROR

robocopy /R:0 /W:0 /NFL /NDL /MIR "%SOURCEDIR%" "%LOCALDIR%" /XD ".svn"
if errorLevel 8 echo *** ERROR: Copying files not sucessful & goto :ERROR

%DOTNETPATH%\Regasm "%LOCALDIR%\IEspeedLibrary.dll" /tlb /codebase
if errorLevel 1 echo *** ERROR: Regasm not sucessful & goto :ERROR

reg add "HKLM\SOFTWARE\Classes\Wow6432Node\CLSID\{74627B42-6755-47CB-8402-AB0914774680}\Implemented Categories\{7DD95801-9882-11CF-9FA9-00AA006C42C4}" /f
reg add "HKLM\SOFTWARE\Classes\Wow6432Node\CLSID\{74627B42-6755-47CB-8402-AB0914774680}\Implemented Categories\{7DD95802-9882-11CF-9FA9-00AA006C42C4}" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\AllowedControls" /v "{74627B42-6755-47CB-8402-AB0914774680}" /t REG_DWORD /d 0 /f

echo.
echo -------------------------------------------------------
echo SUCESSFULLY installed IEspeed
echo -------------------------------------------------------
echo.

IF NOT "%1" == "/s"  pause
exit /b 0

:ERROR
IF NOT "%1" == "/s"  pause
exit /b 1
