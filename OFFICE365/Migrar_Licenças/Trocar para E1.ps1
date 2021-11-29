##
## 
## Script para alteração de licença em massa
##	remove E3 e F3
##	adiciona E1
##


$lista = Import-Csv "C:\temp\E1.CSV" #Gerar CSV a partir do XLS, colocar na primeira linha UserPrincipalName como título

foreach($u in $lista){

    $user = $u.UserPrincipalName

    #-------Definições das licenças no ambiente Hitss-------
    #      
    #      F3 = "reseller-account:DESKLESSPACK"
    #      E1 = "reseller-account:STANDARDPACK"
    #      E3 = "reseller-account:ENTERPRISEPACK"
    #
       

    if ((Get-MsolUser -UserPrincipalName $user | Select -ExpandProperty Licenses | Select-Object accountskuid) -like "*ENTERPRISEPACK*" ){

        Set-MsolUserLicense -UserPrincipalName $user -RemoveLicenses "reseller-account:ENTERPRISEPACK"
        echo "licença E3 Removida"
    }
    if ((Get-MsolUser -UserPrincipalName $user | Select -ExpandProperty Licenses | Select-Object accountskuid) -like "*DESKLESSPACK*" ){
        
        Set-MsolUserLicense -UserPrincipalName $user -RemoveLicenses "reseller-account:DESKLESSPACK"
        echo "licença F3 Removida"
    }   
          
    Set-MsolUserLicense -UserPrincipalName $user -AddLicenses "reseller-account:STANDARDPACK"

        echo "Licença E1 atribuída para $user"
    
    

    

}