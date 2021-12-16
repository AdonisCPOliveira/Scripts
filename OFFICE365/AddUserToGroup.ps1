
#--------- Importando o arquivo com os usuários e seus respectivos grupos

$users = Import-Csv "c:\temp\TempUser.csv" #-Delimiter ';' #-> Alterar o delimiter para ; ou , de acordo com o resultado do salvamento no excel

#--------- Bloco de varredura para atribuir cada usuário para o grupo desejado.

$groupname = "ajustescontaso365"

foreach($u in $users){

    Add-DistributionGroupMember -identity "$groupname" -Member $u.upn

    Echo "$u Adicionado ao Grupo $Groupname"
    }