# Scripts
Meus Scripts

Para os Scripts do PowerShell funcionar instalar os seguintes Modulos:

Exchange Online V2
Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.5

Azure AD
Install-Module -Name AzureAD -force

MSOnline (Office365)
Install-Module MSOnline

Connect to Azure AD
$Msolcred = Get-credential
Connect-MsolService -Credential $MsolCred
connect-AzureAD -Credential $MsolCred 
