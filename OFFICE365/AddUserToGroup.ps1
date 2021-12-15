###############################################################################################

###        O ObjectID DEVE SER COLADO NA COLUNA 'C' DA PLANILHA 'ADDUSERTOGROUP.CSV'        ###

###############################################################################################
#   DisplayName     Mail                               ObjectId                               #
#   -----------     ----                               --------                               #
#   rh_aprendiz_rjo rh_aprendiz_rjo@globalhitss.com.br ea69dc3d-bf05-4c64-91b5-49b6f9f74c7d   #
#   rh_aprendiz_sp  rh_aprendiz_sp@globalhitss.com.br  060cf916-79c0-43a8-b309-c3a6e522d234   #
#   rh_estag_cas    rh_estag_cas@globalhitss.com.br    eea7a33a-8c24-42a8-852c-98f15f3d037a   #
#   rh_estag_df     rh_estag_df@globalhitss.com.br     1202b774-fad1-4f8c-a54a-35a5e9b9eddf   #
#   rh_estag_rjo    rh_estag_rjo@globalhitss.com.br    8fe4df62-a41a-4229-88dc-16b6e30cd0fb   #
#   rh_estag_sp     rh_estag_sp@globalhitss.com.br     7156a7c5-77c6-4ef4-929f-f479fcd885fe   #
#   rhcas           rhcas@globalhitss.com.br           bdfc32ca-b272-4e55-9edf-52ec5ce36d01   #
#   rhdf            df@globalhitss.com.br              25886613-fe32-443c-9a61-68685923f266   #
#   rhibm           ibm@globalhitss.com.br             69fe9f48-4c30-4b9b-99f9-1270de3ea85f   #
#   rhpe            pe@globalhitss.com.br              c5d2a7b1-b239-4f1e-b36f-006da99ee48b   #
#   rhrjo           rj@globalhitss.com.br              4a45259f-c5e0-4c06-bc83-3590e3a74fa1   #
#   rhsp            sp@globalhitss.com.br              222f0282-faa6-466b-8721-b546485ea6eb   #
#                                                                                             #
###############################################################################################

###   CASO SEJA CRIADO UM NOVO GRUPO OU OS GRUPOS ACIMA APRESENTEM ERRO, FAVOR ACIONAR O    ###
###   TIME DE OFFICE 365.                                                                   ###

###############################################################################################


#--------- Importando o arquivo com os usuários e seus respectivos grupos

$users = Import-Csv ".\teste.csv" -Delimiter ';' #-> Alterar o delimiter para ; ou , de acordo com o resultado do salvamento no excel

#--------- Bloco de varredura para atribuir cada usuário para o grupo desejado.

foreach($u in $users){

#$userobjectid = (Get-AzureADUser -objectid $u.upn).objectid
#$gid = $u.GroupID

#Add-AzureADGroupMember -ObjectId $gid -RefObjectId $userobjectid     ##Grupos O365 (Passamos uma raiva até descobrir)

add-distributiongroupmember -identity "Massive Test 2" -member $u.upn


}

