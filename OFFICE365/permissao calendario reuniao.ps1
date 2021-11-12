
#####################################################
# SCRIPT PERMISSAO CALENDARIO REUNIAO RESOURSE ROOM
#####################################################
# GRILLO - 16/09/2020

#faz login no Exchange
$Cred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Cred -Authentication Basic -AllowRedirection
Import-PSSession $Session

# del-MailboxFolderPermission - remove permissão

#Reuniao 1 RJ
Set-MailboxFolderPermission -Identity Reuniao1-rj:\calendar -User default -AccessRights AvailabilityOnly #Todos Visualizam como Busy (LimitedDetails ve o titulo)
Add-MailboxFolderPermission -Identity Reuniao1-rj:\calendar -User ** EMAIL DO USUARIO ** -AccessRights Reviewer


#Desloga do Exchange
Remove-PSSession $Session