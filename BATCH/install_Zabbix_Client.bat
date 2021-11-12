@echo off

REM #DESCRICAO#
REM #Instalao Zabbix via rede nos servidores Windows#
REM #
REM #
REM # LEONARDO GRILLO#
REM # Verifica existencia diretório Zabbix #

REM #MODULO 1#
IF EXIST "c:\Zabbix\zabbix_agentd.exe" (exit) ELSE (echo "Iniciando a instalacao do Zabbix Agent")
REM #
REM # Exibe mensagem na tela#
echo Copiando Arquivos

REM #MODULO 2 - Criar o diretório na máquina#
mkdir c:\zabbix
echo Pasta zabbix criada no C:

REM #MODULO 3 - Realiza a cópia dos binários para o sistema#
copy \\Fs01-rj\install\Zabbix\zabbix_agentd.exe c:\zabbix\
copy \\Fs01-rj\install\Zabbix\zabbix_get.exe c:\zabbix\
copy \\Fs01-rj\install\Zabbix\zabbix_sender.exe c:\zabbix\

REM #MODULO 4 *PUNK* - Cria arquivo de configuração e define nome do servidor #
echo Criando Arquivos de configuracao
echo Server=192.168.103.6 > c:\zabbix\zabbix_agentd.conf
echo Hostname=%COMPUTERNAME% >> c:\zabbix\zabbix_agentd.conf
echo StartAgents=5 >> c:\zabbix\zabbix_agentd.conf
echo DebugLevel=3 >> c:\zabbix\zabbix_agentd.conf
echo LogFile=c:\zabbix\zabbix_agentd.log >> c:\zabbix\zabbix_agentd.conf
echo Timeout=5 >> c:\zabbix\zabbix_agentd.conf
echo EnableRemoteCommands=1 >> C:\zabbix\zabbix_agentd.conf

REM #MODULO 4 - Ajustes Finais #
echo Instalando o Serviço
\\Fs01-rj\install\_TI_Scripts\elevate C:\zabbix\zabbix_agentd.exe -i -c C:\zabbix\zabbix_agentd.conf
\\Fs01-rj\install\_TI_Scripts\elevate C:\zabbix\zabbix_agentd.exe -s -c C:\zabbix\zabbix_agentd.conf
echo As configuracoes para o servidor %COMPUTERNAME% foram criadas em %date% as %time%
echo As configuracoes para o servidor %COMPUTERNAME% foram criadas em %date% as %time% > c:\Zabbix\inst_agent.log
pause