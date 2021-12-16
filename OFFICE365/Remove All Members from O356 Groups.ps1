#connect to Exchange Online
$Cred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Cred -Authentication Basic -AllowRedirection
Import-PSSession $Session


$DistributionGroup = "ajustescontaso365" #O365 Group

#Get List of Group Members
$list = Get-DistributionGroupMember -Identity $DistributionGroup -ResultSize 1500 #ResultSize -> Result Max Return

#Remove all Users
$list | % {
   Remove-DistributionGroupMember -Identity $DistributionGroup -Member $_.Name -Confirm:$false
   } 