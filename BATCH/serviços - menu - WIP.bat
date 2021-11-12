@ECHO on
CLS

setlocal
call :setESC

:MENU
CLS

ECHO.
ECHO.
ECHO.
type art.txt
ECHO.
ECHO.
ECHO    ============= %ESC%[101;93m MAF SERVICES SCRIPT v.1.0 %ESC%[0m =========
::ECHO    =============    LEONARDO GRILLO    =========
ECHO    ---------------------------------------------------
ECHO    1.  %ESC%[1m PARAR SERVICOS WSUS %ESC%[0m
ECHO    2.  %ESC%[1m INICIAR SERVICOS WSUS %ESC%[0m
ECHO    3.  %ESC%[1m INSTALAR ZABBIX CLIENT (WINDOWS) %ESC%[0m
ECHO    4.  %ESC%[1m RESET WINDOWS UPDATE (DESKTOPS) %ESC%[0m
ECHO    5.  %ESC%[1m ATIVAR WIN SRV 2019 STD OPC-1%ESC%[0m
ECHO    6.  %ESC%[1m ATIVAR WIN SRV 2019 STD OPC-2%ESC%[0m
ECHO    7.  %ESC%[1m LIMPA DOWNLOADS e TEMP%ESC%[0m
ECHO    8.  %ESC%[1m INSTALA TREND - GRUPO DEFAULT%ESC%[0m
ECHO    9.  %ESC%[1m AUTO-LOGON%ESC%[0m
ECHO    10. %ESC%[1m VER SERIAL WINDOWS LOCAL%ESC%[0m
ECHO    11. %ESC%[1m WoL PC%ESC%[0m
ECHO    ---------------------------------------------------
ECHO    ========== PRESS %ESC%[92m 'Q' %ESC%[0m TO QUIT ====================
ECHO.

SET INPUT=
SET /P INPUT=SELECIONE UMA OPCAO:

IF /I '%INPUT%'=='1' GOTO Selection1
IF /I '%INPUT%'=='2' GOTO Selection2
IF /I '%INPUT%'=='3' GOTO Selection3
IF /I '%INPUT%'=='4' GOTO Selection4
IF /I '%INPUT%'=='5' GOTO Selection5
IF /I '%INPUT%'=='6' GOTO Selection6
IF /I '%INPUT%'=='7' GOTO Selection7
IF /I '%INPUT%'=='8' GOTO Selection8
IF /I '%INPUT%'=='9' GOTO Selection9
IF /I '%INPUT%'=='10' GOTO Selection10
IF /I '%INPUT%'=='11' GOTO Selection11
IF /I '%INPUT%'=='Q' GOTO Quit

CLS

ECHO ============INVALIDO============
ECHO -------------------------------------
ECHO SELECIONE UMA DAS OPCOES DO MENU
echo Menu [1-11] OU 'Q' PARA SAIR.
ECHO -------------------------------------
ECHO ======PRESSIONE QUALQUER TECLA PARA CONTINUAR======

PAUSE > NUL
GOTO MENU

:Selection1

ECHO PARANDO SERVICOS WSUS...
echo off

net stop wuauserv
net stop bits
net stop dosvc
PAUSE

GOTO MENU

:Selection2

ECHO INICIANDO SERVIÇOS WSUS
echo off

net start wuauserv
net start bits
net start dosvc
PAUSE
GOTO Menu

:Selection3
@ECHO OFF
CALL "\\fs01-rj\INSTALL\_TI_Scripts\Scripts\install_Zabbix_Client.bat"
PAUSE
GOTO Menu

:Selection4
@ECHO OFF
CALL "\\fs01-rj\INSTALL\_TI_Scripts\elevate \\fs01-rj\INSTALL\_TI_Scripts\Scripts\RESET_WSUS.bat"
PAUSE
GOTO Menu

:Selection5
@echo OFF
slmgr.vbs /ipk KNFV4-JX6PY-CF3X8-GFRV8-292H3
GOTO Menu

:Selection6
@echo OFF
slmgr.vbs /ipk GT4JD-4W6TC-6QYTY-XBVVV-QH7PX
GOTO Menu

:Selection7
@echo off
forfiles /p "C:\Users\%username%\Downloads" /s /m *.* /c "cmd /c Del /S /Q @path" /d -10
forfiles /p "C:\Temp" /s /m *.* /c "cmd /c Del /S /Q @path" /d -10
forfiles /p "C:\Windows\Temp" /s /m *.* /c "cmd /c Del /S /Q @path" /d -10
forfiles /p "C:\users\%username%\AppData\Local\Temp" /s /m *.* /c "cmd /c Del /S /Q @path" /d -10
echo.
echo Limpando Lixeira
call "\\Fs01-rj\install\_TI_Scripts\elevate \\fs01-rj\INSTALL\_TI_Scripts\Scripts\limpa_lixeira.bat"
pause
GOTO Menu

:Selection8
@echo OFF
:: Anti-Virus
cscript \\mafdtvm.net.br\NETLOGON\WFBS.vbs
GOTO Menu

:Selection9
@echo OFF
:: Auto-logon
call  "\\fs01-rj\INSTALL\_TI_Scripts\Autologon64.exe"
GOTO Menu

:Selection10
@echo off
wmic path softwareLicensingService get OA3xOriginalProductKey

wmic path softwareLicensingService get OA3xOriginalProductKey >> c:\temp\Serial_%hostname%.txt
Echo Serial gravado na pasta c:\temp

pause

:Selection11
Call "\\fs01-rj\INSTALL\_TI_Scripts\Scripts\WoL.bat"

:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)









@echo off

net start wuauserv
net start bits
net start dosvc

Pause