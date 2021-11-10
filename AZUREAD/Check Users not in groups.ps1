Connect-AzureAD
$groupids = @("222f0282-faa6-466b-8721-b546485ea6eb", "4a45259f-c5e0-4c06-bc83-3590e3a74fa1", "c5d2a7b1-b239-4f1e-b36f-006da99ee48b", "69fe9f48-4c30-4b9b-99f9-1270de3ea85f", "25886613-fe32-443c-9a61-68685923f266", "bdfc32ca-b272-4e55-9edf-52ec5ce36d01", "7156a7c5-77c6-4ef4-929f-f479fcd885fe", "8fe4df62-a41a-4229-88dc-16b6e30cd0fb", "1202b774-fad1-4f8c-a54a-35a5e9b9eddf", "eea7a33a-8c24-42a8-852c-98f15f3d037a")

$userht = @{}
Get-AzureADUser -all $true | foreach-object {$userht.Add($_.ObjectId,$_)} 
ForEach($id  in  $groupids){
$groups = Get-AzureADGroupMember -all $true -ObjectId $id | foreach-object { $userht.Remove($_.ObjectId) }
}
$userht.Values | Select-Object DisplayName, UserPrincipalName, mail | export-CSV "c:\temp\GroupMembers.csv" -NoTypeInformation -Encoding UTF8



#Get-AzureADUser -Top 100
#Get-AzureADUserMembership -ObjectId 15c9fa3d-e881-4c5d-a210-83a3be8d15bf
#Get-AzureADGroupMember -ObjectId 441f1198-b690-466f-9ecd-b23a2fa03646
