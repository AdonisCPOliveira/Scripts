$M365credentials = Get-Credential
Connect-MsolService -Credential $M365credentials
Connect-AzureAD -Credential $M365credentials

Function Export-UsersLicensesConfig {

    #License Plans correspondence table with friendly name
    
    $LicensePlan = @{         
              ##<companyname>:<Licenseplan> = <license plan friendly name>          
                      "koaf365:AAD_PREMIUM" = "AzureAD Premium Plan 1"             
                   "koaf365:AX7_USER_TRIAL" = "Dynamics AX7.0 TRIAL"         
                     "koaf365:DESKLESSPACK" = "OFFICE 365 F1"       
          "koaf365:DYN365_ENTERPRISE_P1_IW" = "Dynamics 365 Enterprise Plan1"   
              "koaf365:DYN365_RETAIL_TRIAL" = "Dynamics 365 CRM TRIAL"               
                              "koaf365:EMS" = "EMS_E3"             
                       "koaf365:EMSPREMIUM" = "EMS_E5"        
                   "koaf365:ENTERPRISEPACK" = "E3"             
                "koaf365:ENTERPRISEPREMIUM" = "E5"          
                        "koaf365:FLOW_FREE" = "Microsoft Flow"            
                      "koaf365:INTUNE_A_VL" = "Intune Volume License"        
                       "koaf365:MCOMEETADV" = "Skype For Business PSTN Conferencing"   
        "koaf365:MICROSOFT_BUSINESS_CENTER" = "Microsoft Business Center"          
                     "koaf365:POWER_BI_PRO" = "Power BI PRO"         
                "koaf365:POWER_BI_STANDARD" = "Power BI Standard"    
        "koaf365:POWERAPPS_INDIVIDUAL_USER" = "Powerapps Individual User"           
                  "koaf365:POWERAPPS_VIRAL" = "Microsoft PowerApps and Logic flows"        
                   "koaf365:PROJECTPREMIUM" = "Project Online Premium"        
                     "koaf365:STANDARDPACK" = "E1"                
                           "koaf365:STREAM" = "Stream"         
                "koaf365:VISIOONLINE_PLAN1" = "Visio Online Plan 1"           
              "koaf365:WACONEDRIVESTANDARD" = "OneDrive For Business Plan 1"       
                      "koaf365:WIN_DEF_ATP" = "Windows Defender Avanced Threat Protection"
    }
    
    #Initializing users licenses config table
    $Us = @()

    #Getting all users list    
    $Users = Get-MsolUser -All | ?{$_.isLicensed -eq $true}

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
    $Us | Select userPrincipalName, O365Licenses, EnabledFeature, DisabledFeature | Export-Csv UserLicensesConfig.csv -NoTypeInformation -Delimiter ";" -Encoding UTF8
}
