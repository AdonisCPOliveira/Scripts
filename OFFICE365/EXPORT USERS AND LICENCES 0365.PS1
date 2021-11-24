$M365credentials = Get-Credential
Connect-MsolService -Credential $M365credentials
Connect-AzureAD -Credential $M365credentials

Function Export-UsersLicensesConfig {

    #License Plans correspondence table with friendly name, please set companyname where is "reseller account"
    
    $LicensePlan = @{         
              ##<companyname>:<Licenseplan> = <license plan friendly name>          
                      "reseller-account:AAD_PREMIUM" = "AzureAD Premium Plan 1"             
                   "reseller-account:AX7_USER_TRIAL" = "Dynamics AX7.0 TRIAL"         
                     "reseller-account:DESKLESSPACK" = "OFFICE 365 F1"       
          "reseller-account:DYN365_ENTERPRISE_P1_IW" = "Dynamics 365 Enterprise Plan1"   
              "reseller-account:DYN365_RETAIL_TRIAL" = "Dynamics 365 CRM TRIAL"               
                              "reseller-account:EMS" = "EMS_E3"             
                       "reseller-account:EMSPREMIUM" = "EMS_E5"        
                   "reseller-account:ENTERPRISEPACK" = "E3"             
                "reseller-account:ENTERPRISEPREMIUM" = "E5"          
                        "reseller-account:FLOW_FREE" = "Microsoft Flow"            
                      "reseller-account:INTUNE_A_VL" = "Intune Volume License"        
                       "reseller-account:MCOMEETADV" = "Skype For Business PSTN Conferencing"   
        "reseller-account:MICROSOFT_BUSINESS_CENTER" = "Microsoft Business Center"          
                     "reseller-account:POWER_BI_PRO" = "Power BI PRO"         
                "reseller-account:POWER_BI_STANDARD" = "Power BI Standard"    
        "reseller-account:POWERAPPS_INDIVIDUAL_USER" = "Powerapps Individual User"           
                  "reseller-account:POWERAPPS_VIRAL" = "Microsoft PowerApps and Logic flows"        
                   "reseller-account:PROJECTPREMIUM" = "Project Online Premium"        
                     "reseller-account:STANDARDPACK" = "E1"                
                           "reseller-account:STREAM" = "Stream"         
                "reseller-account:VISIOONLINE_PLAN1" = "Visio Online Plan 1"           
              "reseller-account:WACONEDRIVESTANDARD" = "OneDrive For Business Plan 1"       
                      "reseller-account:WIN_DEF_ATP" = "Windows Defender Avanced Threat Protection"
                "reseller-account:TEAMS_EXPLORATORY" = "Microsoft Teams Exploratory"
    }
    
    #Initializing users licenses config table
    $Us = @()

    #Getting all users list    
    $Users = Get-MsolUser -all | Where-Object {$_.isLicensed -eq "True"}

    ForEach($u in $Users){          
   
        #Getting assigned user License Plans        
        $O365Licenses = @()        
        $u.Licenses.AccountSkuId | % {            
            $O365Licenses += $LicensePlan."$_"        
        }        
        $O365Licenses = [string]::Join(',',$O365Licenses)            
    
        #Getting user enabled license features        
        $EnabledFeature = ($u.Licenses | Select -ExpandProperty ServiceStatus | ?{($_.ProvisioningStatus -eq "Success")}).ServicePlan.ServiceName        
        If (($EnabledFeature -ne $null) -and ($EnabledFeature.GetType().BaseType.Name -eq "Array")){                       
            $EnabledFeature = [string]::Join(',',$EnabledFeature)        
        }
        
        #Getting user license disabled features        
        $DisabledFeature = ($u.Licenses | Select -ExpandProperty ServiceStatus | ?{($_.ProvisioningStatus -eq "Disabled")}).ServicePlan.ServiceName        
        If (($DisabledFeature -ne $null) -and ($DisabledFeature.GetType().BaseType.Name -eq "Array")){                 
            $DisabledFeature = [string]::Join(',',$DisabledFeature)        
        }

        #Updating users Licenses config table       
        $u | Add-Member -MemberType NoteProperty -Name EnabledFeature -Value $EnabledFeature -Force        
        $u | Add-Member -MemberType NoteProperty -Name DisabledFeature -Value $DisabledFeature -Force        
        $u | Add-Member -MemberType NoteProperty -Name O365Licenses -Value $O365Licenses -Force                 
        $Us += $u

    }

    #Exporting user License config    
    $Us | Select userPrincipalName, O365Licenses, EnabledFeature, DisabledFeature #| Export-Csv d:\temp\UserLicensesConfig.csv -NoTypeInformation -Delimiter ";" -Encoding UTF8
}
Export-UsersLicensesConfig
