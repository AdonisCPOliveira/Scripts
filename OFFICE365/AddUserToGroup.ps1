



###############################################################################################

###   CASO SEJA CRIADO UM NOVO GRUPO OU OS GRUPOS ACIMA APRESENTEM ERRO, FAVOR ACIONAR O    ###
###   TIME DE OFFICE 365.                                                                   ###
###   USAR PSESSION DO EXCHANGE ONLINE
###############################################################################################


#--------- Importando o arquivo com os usuários e seus respectivos grupos

$users = Import-Csv ".\teste.csv" -Delimiter ';' #-> Alterar o delimiter para ; ou , de acordo com o resultado do salvamento no excel

#--------- Bloco de varredura para atribuir cada usuário para o grupo desejado.

foreach($u in $users){

#$userobjectid = (Get-AzureADUser -objectid $u.upn).objectid
#$gid = $u.GroupID

#Add-AzureADGroupMember -ObjectId $gid -RefObjectId $userobjectid     ##Grupos O365 (Passamos uma raiva até descobrir)

Add-DistributionGroupMember -identity "Temp_list_comunica" -Member $u.upn


}

