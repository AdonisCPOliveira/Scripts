# Scripts
Meus Scripts

Para os Scripts do PowerShell funcionar instalar os seguintes Modulos:

Siga os Passos:

(1) Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine

Exchange Online V2:

(2) Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.5

Azure AD:

93) Install-Module -Name AzureAD -force

MSOnline (Office365):

(4) Install-Module MSOnline

### Connect to Azure AD:

$Msolcred = Get-credential

Connect-MsolService -Credential $MsolCred

connect-AzureAD -Credential $MsolCred 

### faz login no Exchange

$Cred = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Cred -Authentication Basic -AllowRedirection

Import-PSSession $Session
