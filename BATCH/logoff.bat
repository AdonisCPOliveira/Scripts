:start
@echo off
echo.
echo Choose an option below:
echo ****************************
echo [1] Remote Log Off User
echo [2] Exit
echo ****************************
echo.
choice /C:123 /N /M "Choose an option [1, 2]: "
if ERRORLEVEL 2 goto end
if ERRORLEVEL 1 goto choice1

:choice1
cls
set /p CompName= Which computer is a user logged into?
C:\script\marista\PSToos\psexec.exe \\%CompName% query session
echo.
set /p SessionNum= Which session is the user in question on?
C:\script\marista\PSToos\psexec.exe \\%CompName% logoff %SessionNum%
goto start

:end
pause

exit /B