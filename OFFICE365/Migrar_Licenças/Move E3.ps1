##
## 
## Script para alteração de licença em massa
##	remove E1 e F3
##	adiciona E3
##




$lista = Import-Csv "C:\temp\E3.CSV"

foreach($u in $lista){

    $user = $u.UserPrincipalName

    #-------Definições das licenças no ambiente Hitss-------
    #      
    #      F3 = "reseller-account:DESKLESSPACK"
    #      E1 = "reseller-account:STANDARDPACK"
    #      E3 = "reseller-account:ENTERPRISEPACK"
    #


    if ((Get-MsolUser -UserPrincipalName $user | Select -ExpandProperty Licenses | Select-Object accountskuid) -like "*STANDARDPACK*" ){

        Set-MsolUserLicense -UserPrincipalName $user -RemoveLicenses "reseller-account:STANDARDPACK"
        echo "licença  $user E1 Removida"
    }
    if ((Get-MsolUser -UserPrincipalName $user | Select -ExpandProperty Licenses | Select-Object accountskuid) -like "*DESKLESSPACK*" ){
        
        Set-MsolUserLicense -UserPrincipalName $user -RemoveLicenses "reseller-account:DESKLESSPACK"
        echo "licença $user F3 Removida"
    }   
          
    Set-MsolUserLicense -UserPrincipalName $user -AddLicenses "reseller-account:ENTERPRISEPACK"

        echo "Licença E3 atribuída para $user"
    
    

    

}