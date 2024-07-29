@echo off

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

powerShell -Command "Write-Host 'My github -> https://github.com/fatiqueos' -ForegroundColor Green; exit" && timeout 04>nul

IF exist PowerRun.exe (
    echo ok
) ELSE (
    echo powerrun not present! && pause && exit /b 1
)

:MAINMENU
CLS
SET MENU=
ECHO WINDOWS SMARTSCREEN MANAGER
echo.
ECHO [1] Disable SmartScreen
ECHO [2] Enable SmartScreen
ECHO [0] EXIT
echo.
SET /P MENU=Type 1, 2 or 0 then press ENTER :
IF /I '%MENU%'=='1' GOTO :disable
IF /I '%MENU%'=='2' GOTO :enable
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :MAINMENU

rem ####################################################################################### 

:disable

rem Disable SmartScreen Filter
PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f"
PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableFilter" /t REG_DWORD /d 0 /f"

powershell write-host -fore Green "Done, rebooting in 5 seconds"
timeout 5
shutdown /r /t 00 

:enable

rem Enable SmartScreen Filter
PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 1 /f"
PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableFilter" /t REG_DWORD /d 1 /f"

powershell write-host -fore Green "Done, rebooting in 5 seconds"
timeout 5
shutdown /r /t 00 

:EXIT
exit
