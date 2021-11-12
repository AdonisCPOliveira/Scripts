## CRIADO Pela equipe N3
## DATA 16/06/2020
## CONECTAR NO VMWARE
## VCENTER ##
# CRIAR A TASK COM AS STRINGS -Command "C:\Script\dclapa\rvtools\rvtools.ps1" -ExecutionPolicy Bypass -passthroughAuth

#INFORMAR IPS DO VCENTER
$VCENTER_CRUX = "10.96.211.35"
$VCENTER_VXRAIL = "10.96.211.18"

#INFORMAR PASTA ONDE SERÁ RAVADO O XLS
$DIRETORIO_CRUX = "C:\script\Cliente\rvtools"
$DIRETORIO_VXRAIL = "C:\script\Cliente\rvtools"

#NOME DO ARQUIVO
$FILE_CRUX= "RVTools-Cliente-Crux"
$FILE_VXRAIL= "RVTools-Cliente-VxRail"

#REMOVE ANTIGOS
rm "C:\script\Cliente\rvtools\RVTools-Cliente-Crux.xlsx"
rm "C:\script\Cliente\rvtools\RVTools-Cliente-VxRail.xlsx"

RVTools.exe -passthroughAuth -s $VCENTER_CRUX -u snapshotwipe@vsphere.int -p "Noa.8n,.9Z}@NY" -c ExportAll2xls -d $DIRETORIO_CRUX -f $FILE_CRUX

sleep 500

$filelocation = $DIRETORIO_CRUX+"\"+$FILE_CRUX+".xlsx"


RVTools.exe -passthroughAuth -s $VCENTER_VXRAIL -u Usuário -p "SENHA" -c ExportAll2xls -d $DIRETORIO_VXRAIL -f $FILE_VXRAIL

sleep 500

$filelocationa = $DIRETORIO_VXRAIL+"\"+$FILE_VXRAIL+".xlsx"


##############################################################################
# E-mail HTML output #
# PREENCHER DADOS DE EMAIL
##############################################################################
$From = ""
$To = ""
$To1 = ""
$To2 = ""
$To3 = ""
$Cc = ""
$Cc2 = ""
$Attachment = $filelocation
$Attachmenta = $filelocationa
$Subject = "RELATÓRIO RVTOOLS"
$Body = �Anexo RVTools do ambiente

10.96.211.35 - VCENTER_CRUX
10.96.211.18 - VCENTER_VXRAIL



#Obs.: Qualquer problema neste script / relatorio informar a equipe N3 �
$SMTPServer = ""
Send-MailMessage -From $From -to $To,$To1,$To2,$To3 -Cc $Cc,$Cc2 -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -Attachments $Attachment,$Attachmenta
