## CRIADO Pela Equipe N3
## DATA 15/06/2020
## Script que envia uma lista de VMs com SNAPSHOTs por e-mail.
# CRIAR A TASK COM AS STRINGS -Command "C:\Script\dclapa\snapshot\snapshot.ps1"  -ExecutionPolicy Bypass -passthroughAuth

invoke-expression -Command "C:\script\Cliente\Desligadas\Initialize-PowerCLIEnvironment.ps1"

####################################
# VMware VirtualCenter server name #
####################################
$vcservervxrail="10.96.211.18"


##################
# Add VI-toolkit #
##################

connect-VIServer $vcservervxrail -user vitor.retta@grupoCliente.local -password "Mudar@@2019"

Get-VM | where {$_.powerstate -eq �PoweredOff�} | ft -autosize  | out-file C:\script\Cliente\Desligadas\VMdesligada-vCenterVXRAIL.txt

$filelocation = "C:\script\Cliente\Desligadas\VMdesligada-vCenterVXRAIL.txt"


##############################################################################
# E-mail HTML output #
##############################################################################
$From = ""
$To = ""
$To1 = ""
$To2 = ""
$To3 = ""
$Cc = ""
$Cc2 = ""
$Attachment = $filelocation
$Subject = "Grupo Cliente > Relatorio Quinzenal de VMs desligadas"
$Body = "Relatorio diario contendo todas as VMs desligadas no ambiente. 

Ambiente VCENTER.


10.96.211.18 - VCENTER_VXRAIL


#Obs.: Qualquer problema neste script / relatorio informar a equipe N3s. "
$SMTPServer = "smtps2.pucpr.br"
Send-MailMessage -From $From -to $To,$To1,$To,$To2,$To3 -Cc $Cc,$Cc2 -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -Attachments $Attachment