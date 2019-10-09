# Install AD services and tools
Write-Output 'Installing Active Directory serices and tools...'

Add-WindowsFeature "RSAT-AD-Tools"

start-job -Name addFeature -ScriptBlock { 
    Add-WindowsFeature -Name "ad-domain-services" -IncludeAllSubFeature -IncludeManagementTools 
    Add-WindowsFeature -Name "dns" -IncludeAllSubFeature -IncludeManagementTools 
    Add-WindowsFeature -Name "gpmc" -IncludeAllSubFeature -IncludeManagementTools } 
Wait-Job -Name addFeature

Import-Module ADDSDeployment

Write-Output 'Creating Active Directory Domain: globomantics.local'
Install-ADDSForest `
-SkipPreChecks:$true `
-SafeModeAdministratorPassword (ConvertTo-SecureString -String "P@ssw0rd1!" -AsPlainText -Force) `
-CreateDnsDelegation:$false `
-DatabasePath "C:/Windows/NTDS" `
-DomainMode "Win2012R2" `
-DomainName "globomantics.local" `
-DomainNetbiosName "globomantics" `
-ForestMode "Win2012R2" `
-InstallDns:$true `
-LogPath "C:/Windows/NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:/Windows/SYSVOL" `
-Force:$true