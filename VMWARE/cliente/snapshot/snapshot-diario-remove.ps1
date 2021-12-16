## CRIADO Pela Equipe N3
## DATA 15/06/2020
## Script que envia uma lista de VMs com SNAPSHOTs por e-mail.
# CRIAR A TASK COM AS STRINGS -Command "C:\Script\dclapa\snapshot\snapshot.ps1"  -ExecutionPolicy Bypass -passthroughAuth

invoke-expression -Command "C:\script\marista\snapshot\Initialize-PowerCLIEnvironment.ps1"

####################################
# VMware VirtualCenter server name #
####################################
$vcservercrux="IP"
$vcservervxrail="IP"


##################
# Add VI-toolkit #
##################
Add-PSsnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue
connect-VIServer $vcservercrux -user USUARIO -password "SENHA"

Get-VM | Get-Snapshot | Select VM,Name,@{N="SizeGB";E={@([math]::Round($_.SizeGB))}},Created, Description | Where {$_.Name -like "*Ticket*" -or $_.Name -like "*GMUD*" -and $_.Created -lt (Get-Date).AddDays(-3)} | out-file C:\script\marista\snapshot\snapmarista-vcentercrux-maisde3dias.txt

$filelocation = "C:\script\marista\snapshot\snapmarista-vcentercrux-maisde3dias.txt"

Get-VM | Get-Snapshot | Where {$_.Name -like "*Ticket*" -or $_.Name -like "*GMUD*" -and $_.Created -lt (Get-Date).AddDays(-3)} | Remove-Snapshot -Confirm:$false


###

connect-VIServer $vcservervxrail -user USUARIO -password "SENHA"

Get-VM | Get-Snapshot | Select VM,Name,@{N="SizeGB";E={@([math]::Round($_.SizeGB))}},Created, Description | Where {$_.Name -like "*Ticket*" -or $_.Name -like "*GMUD*" -and $_.Created -lt (Get-Date).AddDays(-3)} | out-file C:\script\marista\snapshot\snapmarista-vcentervxrail-maisde3dias.txt

$filelocationa = "C:\script\marista\snapshot\snapmarista-vcentervxrail-maisde3dias.txt"

Get-VM | Get-Snapshot | Where {$_.Name -like "*Ticket*" -or $_.Name -like "*GMUD*" -and $_.Created -lt (Get-Date).AddDays(-3)} | Remove-Snapshot -Confirm:$false



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
$Attachmenta = $filelocationa
$Subject = ""
$Body = "Relatorio diario contendo todas as VMs seus snapshots foram removidos. 

Ambiente VCENTER.


 - VCENTER_CRUX
 - VCENTER_VXRAIL


#Obs.: Qualquer problema neste script / relatorio informar a equipe N3"
$SMTPServer = ""
Send-MailMessage -From $From -to $To,$To1,$To2,$To3 -Cc $Cc,$Cc2 -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -Attachments $Attachment,$Attachmenta