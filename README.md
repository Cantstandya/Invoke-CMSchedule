# Invoke-CMSchedule
This PowerShell script is used to trigger ConfigMgr client actions remotely, for example "Application Deployment Evaluation Cycle" or "Machine Policy Retrieval Cycle".

Since the script uses the WMI methods of the ConfigMgr agent to trigger the actions the clients must be configured to allow remote WMI connections

## Parameters

- **-ComputerName**, Defines the computer to trigger the action on, accepts an array of computers.
- **-Action**, Defines the action to be triggered on the remote computer. Accepted values:

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

## Examples

`.\Invoke-CMSchedule.ps1 -ComputerName Client01 -Action ApplicationDeploymentEvaluationCycle`

This command will trigger the action "Application Deployment Evaluation Cycle" on the computer Client01.

`.\Invoke-CMSchedule.ps1 -ComputerName (Get-Content C:\Computers.txt) -Action MachinePolicyRetrievalCycle -Verbose`

This command will trigger the action "Machine Policy Retrieval Cycle" on all computers specified in the file "C:\Computers.txt" with verbose output.

## Credits

Written by: Mikael Ekberg