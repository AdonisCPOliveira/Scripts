Connect-AzureAD

#ALTERE AQUI AS OPCOES
$disc = "E:\" #ONDE VAI GRAVAR O CSV


#EXECUÇÃO DO COMANDO - NAO ALTERAR

$list_group = Get-AzureADGroup -SearchString "DHCP Administrators" #PROCURA TODOS GRUPOS COM NOME
#$list_group = Get-AzureADGroup -Filter "DisplayName eq '$GroupName'" #PROCURA POR UM GRUPO

if ($list_group -ne $null) {
    for ($i=0; $i -lt $list_group.Length;$i++){
        $groupobj = $list_group[$i].ObjectId
        $GroupName = $list_group[$i].DisplayName
        $b = $i
        $get_group_info = Get-AzureADGroupMember -ObjectId $groupobj -All $true  |  Select DisplayName, UserPrincipalName, department, mail, physicalDeliveryOfficeName, title |
        export-CSV $disc"GroupMembers_$GroupName.csv" -NoTypeInformation -Encoding UTF8
    }}
    