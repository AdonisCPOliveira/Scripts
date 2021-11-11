Connect-ExchangeOnline -UserPrincipalName joao.pulse@dominio.com

$usuario = $null
$usuarios = $null
$usuarios = Import-Csv -Delimiter ";" -Path "C:\Users\JoãoPedroFPavan\OneDrive - Pulse Soluções em Informática Ltda\Documentos\xxx\CSVs\UsuáriosSharedMailbox.csv"            
foreach ($usuario in $usuarios)            
{            
    $Dnome = $usuario.nome
    $mail = $usuario.email
    $snome = $usuario.account
    
   New-Mailbox -Shared -Name $snome -DisplayName $dnome -PrimarySmtpAddress $mail
   Set-Mailbox $mail -HiddenFromAddressListsEnabled $true
   Set-Mailbox $mail -RequireSenderAuthenticationEnabled $true  
}
