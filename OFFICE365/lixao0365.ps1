##
## 
## Script para alteração de licença em massa
##	remove E3 e F3 E1 TEAMS e Desabilita as contas
##	
##


$lista = Import-Csv "C:\temp\REMOVE.CSV" #Gerar CSV a partir do XLS, colocar na primeira linha UserPrincipalName como título

foreach($u in $lista){

    $user = $u.UserPrincipalName

    #REMOVE COM LIXEIRA  
    #Remove-AzureADUser -ObjectId $user
   
    #REMOVE SEM LIXEIRA
    Remove-MsolUser -UserPrincipalName  $user
 echo "$user Excluído"
    

}
