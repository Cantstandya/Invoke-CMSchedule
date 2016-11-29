<#
.SYNOPSIS
    A PowerShell script to trigger ConfigMgr client actions remotely
.DESCRIPTION
    This PowerShell script is used to trigger ConfigMgr client actions remotely, for example "Application Deployment Evaluation Cycle" or "Machine Policy Retrieval Cycle".
    Since the script uses the WMI methods of the ConfigMgr agent to trigger the actions the clients must be configured to allow remote WMI connections
.PARAMETER ComputerName
    Defines the computer to trigger the action on, accepts an array of computers.
.PARAMETER Action
    Defines the action to be triggered on the remote computer. Accepted values:

    ApplicationDeploymentEvaluationCycle
    DiscoveryDataCollectionCycle
    FileCollectionCycle
    HardwareInventoryCycle
    MachinePolicyRetrievalCycle
    MachinePolicyEvaluationCycle
    SoftwareInventoryCycle
    SoftwareMeteringUsageReportCycle
    SoftwareUpdatesAssignmentsEvaluationCycle
    SoftwareUpdateScanCycle
    StateMessageRefresh
    UserPolicyRetrievalCycle
    UserPolicyEvaluationCycle
    WindowsInstallersSourceListUpdateCycle
.EXAMPLE
    PS C:\> .\Invoke-CMSchedule.ps1 -ComputerName Client01 -Action ApplicationDeploymentEvaluationCycle

    This command will trigger the action "Application Deployment Evaluation Cycle" on the computer Client01.
.EXAMPLE
    PS C:\> .\Invoke-CMSchedule.ps1 -ComputerName (Get-Content C:\Computers.txt) -Action MachinePolicyRetrievalCycle -Verbose

    This command will trigger the action "Machine Policy Retrieval Cycle" on all computers specified in the file "C:\Computers.txt" with verbose output.
.LINK
    https://github.com/Cantstandya/Invoke-CMSchedule
#>

[CmdLetBinding()]
Param
(
    [Parameter(Position=0, Mandatory = $true)]
    [String[]] $ComputerName,

    [Parameter(Position=1, Mandatory = $true)]
    [ValidateSet("ApplicationDeploymentEvaluationCycle","DiscoveryDataCollectionCycle","FileCollectionCycle","HardwareInventoryCycle","MachinePolicyRetrievalCycle","MachinePolicyEvaluationCycle","SoftwareInventoryCycle","SoftwareMeteringUsageReportCycle","SoftwareUpdatesAssignmentsEvaluationCycle","SoftwareUpdateScanCycle","StateMessageRefresh","UserPolicyRetrievalCycle","UserPolicyEvaluationCycle","WindowsInstallersSourceListUpdate Cycle")]
    [String] $Action
 )

Switch ($Action)
{
    "ApplicationDeploymentEvaluationCycle"{$Trigger = "{00000000-0000-0000-0000-000000000121}"}
    "DiscoveryDataCollectionCycle"{$Trigger = "{00000000-0000-0000-0000-000000000003}"}
    "FileCollectionCycle"{$Trigger = "{00000000-0000-0000-0000-000000000010}"}
    "HardwareInventoryCycle"{$Trigger = "{00000000-0000-0000-0000-000000000001}"}
    "MachinePolicyRetrievalCycle"{$Trigger = "{00000000-0000-0000-0000-000000000021}"}
    "MachinePolicyEvaluationCycle"{$Trigger = "{00000000-0000-0000-0000-000000000022}"}
    "SoftwareInventoryCycle"{$Trigger = "{00000000-0000-0000-0000-000000000002}"}
    "SoftwareMeteringUsageReportCycle"{$Trigger = "{00000000-0000-0000-0000-000000000031}"}
    "SoftwareUpdatesAssignmentsEvaluationCycle"{$Trigger = "{00000000-0000-0000-0000-000000000108}"}
    "SoftwareUpdateScanCycle"{$Trigger = "{00000000-0000-0000-0000-000000000113}"}
    "StateMessageRefresh"{$Trigger = "{00000000-0000-0000-0000-000000000111}"}
    "UserPolicyRetrievalCycle"{$Trigger = "{00000000-0000-0000-0000-000000000026}"}
    "UserPolicyEvaluationCycle"{$Trigger = "{00000000-0000-0000-0000-000000000027}"}
    "WindowsInstallersSourceListUpdateCycle"{$Trigger = "{00000000-0000-0000-0000-000000000032}"}
}

foreach($Computer in $ComputerName){
    try{
        Invoke-WmiMethod -ComputerName $Computer -Namespace root\ccm -Class sms_client -Name TriggerSchedule -ArgumentList $Trigger -ErrorAction Stop | Out-Null
        Write-Verbose "Successfully triggered $Action on $Computer"
    }
    catch{
        Write-Warning "Failed to trigger $Action on $Computer"
        Write-Warning $_.Exception.Message
    }
}