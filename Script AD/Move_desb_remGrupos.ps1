# ------------------------------------------------------------------ 
# space to import all modules 
ipmo ActiveDirectory # load module from Active Directory
#-------------------------------------------------------------------
$date = Get-Date
[string]$dia = $date
[string]$mes = $date
[string]$ano = $date
[string]$date_file1 = $mes.substring(3,2) + $dia.substring(0,2) + $ano.substring(6,4)
[string]$date_file = $mes.substring(3,2) + "/" + $dia.substring(0,2) + "/" + $ano.substring(6,4)


$OUDesabilitados = "OU=Desativados,DC=hidelbra,DC=intra" #### OU DESATIVADOS/DESABILITADOS
$lista = Import-Csv "C:\temp\desabilitar.CSV" #Gerar CSV a partir do XLS, colocar na primeira linha UserPrincipalName como título

foreach($u in $lista){
    $get_user_info = Get-ADUser $u.UserPrincipalName -properties *
    $groups = $get_user_info.memberof
    Disable-ADAccount -Identity $get_user_info.SamAccountName
    Get-ADUser $get_user_info.SamAccountName | Move-ADObject -TargetPath "$OUDesabilitados"
    Set-ADUser $get_user_info.SamAccountName -Homepage "Migrado para OU Desativados em: $date_file"
    $groups | Remove-ADGroupMember -Confirm:$false -member $get_user_info.SamAccountName

    echo ("Usuario " + $get_user_info.Name +" Foi Desabilitado, Grupos Removidos e Movido para OU Desativados em $date_file")

    }
