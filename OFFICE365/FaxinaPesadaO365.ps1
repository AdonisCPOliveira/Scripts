##
## 
## Script para alteração de licença em massa
##	remove E3 e F3 E1 TEAMS e Desabilita as contas
##	
##


$lista = Import-Csv "C:\temp\REMOVE.CSV" #Gerar CSV a partir do XLS, colocar na primeira linha UserPrincipalName como título

foreach($u in $lista){

    $user = $u.UserPrincipalName

    #-------Definições das licenças no ambiente Hitss-------
    #      
    #      F3 = "reseller-account:DESKLESSPACK"
    #      E1 = "reseller-account:STANDARDPACK"
    #      E3 = "reseller-account:ENTERPRISEPACK"
    #      "reseller-account:TEAMS_EXPLORATORY" = "Microsoft Teams Exploratory"
       

    if ((Get-MsolUser -UserPrincipalName $user | Select -ExpandProperty Licenses | Select-Object accountskuid) -like "*ENTERPRISEPACK*" ){

        Set-MsolUserLicense -UserPrincipalName $user -RemoveLicenses "reseller-account:ENTERPRISEPACK"
        echo "licença E3 Removida"
    }
    if ((Get-MsolUser -UserPrincipalName $user | Select -ExpandProperty Licenses | Select-Object accountskuid) -like "*DESKLESSPACK*" ){
        
        Set-MsolUserLicense -UserPrincipalName $user -RemoveLicenses "reseller-account:DESKLESSPACK"
        echo "licença F3 Removida"
    }   
     
     if ((Get-MsolUser -UserPrincipalName $user | Select -ExpandProperty Licenses | Select-Object accountskuid) -like "*STANDARDPACK*" ){
        
        Set-MsolUserLicense -UserPrincipalName $user -RemoveLicenses "reseller-account:STANDARDPACK"
        echo "licença E1 Removida"
    }   

    
     if ((Get-MsolUser -UserPrincipalName $user | Select -ExpandProperty Licenses | Select-Object accountskuid) -like "*TEAMS_EXPLORATORY*" ){
        
        Set-MsolUserLicense -UserPrincipalName $user -RemoveLicenses "reseller-account:TEAMS_EXPLORATORY"
        echo "licença TEAMS Removida"
    }   

    Set-AzureADUser -ObjectID $user -AccountEnabled $false
    echo "$user Dasabilitado"

    #Remove-AzureADUser -ObjectId $user
    
    

    

}
