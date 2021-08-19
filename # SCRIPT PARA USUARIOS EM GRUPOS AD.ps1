Connect-AzureAD

#ALTERE AQUI AS OPCOES
$disc = "E:\" #ONDE VAI GRAVAR O CSV
$GroupName = "VPN-servers-svn" #NOME DO GRUPO

#EXECUÇÃO DO COMANDO - NAO ALTERAR
$Group = Get-AzureADGroup -Filter "DisplayName eq '$GroupName'"
Get-AzureADGroupMember -ObjectId $Group.ObjectId -All $true  |  Select DisplayName, UserPrincipalName, department, mail, physicalDeliveryOfficeName, title |
Export-CSV $disc"GroupMembers_$GroupName.csv" -NoTypeInformation -Encoding UTF8

