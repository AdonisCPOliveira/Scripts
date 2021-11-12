@ECHO OFF

net stop wuauserv
net stop bits 
net stop cryptsvc 
net stop msiserver

C:
CD\
CD %windir%

if exist %windir%\SoftwareDistribution.OLD (
    Echo ENCONTRADO PASTA ANTIGA DO WSUS.... REMOVENDO....
    del /q /s "SoftwareDistribution.OLD\*"
    for /D %%p IN ("%windir%\SoftwareDistribution.OLD\*.*") DO rmdir "%%p" /s /q
)
rmdir %windir%\SoftwareDistribution.OLD

ECHO CRIANDO BKP DO WSUS...
REN SoftwareDistribution SoftwareDistribution.OLD

net start bits
net start wuauserv
net start cryptsvc
net start MSIServer

netsh winsock reset all
netsh int 6to4 reset all
netsh int ipv4 reset all
netsh int ipv6 reset all
netsh int httpstunnel reset all
netsh int isatap reset all
netsh int portproxy reset all
netsh int tcp reset all
netsh int teredo reset all

echo WSUS REVISAO  %date% %time% %username% > C:\TEMP\wsus.txt