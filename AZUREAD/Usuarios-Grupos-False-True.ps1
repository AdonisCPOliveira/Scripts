$Group = Get-AzureADGroup -SearchString "rhsp"
$Users = Get-AzureADUser -All:$true 
$GroupMembers = (Get-AzureADGroupMember -All $true -ObjectId $Group.ObjectID | Select ObjectId )
$Results = @()
Foreach ($User in $Users){
    If ($GroupMembers -Match $user.ObjectID) {
            $results += New-Object psObject -Property @{'User'=$user.DisplayName;'Groups'= $Group.DisplayName; 'Member'="True"}
        }else{
            $results += New-Object psObject -Property @{'User'=$user.DisplayName;'Groups'= $Group.DisplayName; 'Member'="False"}
        }
}

$Results | Export-Csv -NoTypeInformation -Path "$env:USERPROFILE\Downloads\$GroupReport.csv"


#$GroupMembers = (Get-AzureADGroupMember -All $true -ObjectId $Group.ObjectID | Sort-Object -Property DisplayName )
