# Script to pin vCenter to Host 1 and NSX to Host 2 in Holodeck Environments

Import-Module VCF.PowerCLI

# Set Site - A or B
$HoloSite = "A"



If ($HoloSite -eq "A") {

$vCenter = "vc-mgmt-a.site-a.vcf.lab"
$Host1 = "esx-01a.site-a.vcf.lab"
$Host2 = "esx-02a.site-a.vcf.lab"
$Cluster = "cluster-mgmt-01a"
$vcVM = "vc-mgmt-a"
$nsxVM = "nsx-mgmt-01a"

}

ElseIf ($HoloSite -eq "B") {

$vCenter = "vc-mgmt-b.site-b.vcf.lab"
$Host1 = "esx-01b.site-b.vcf.lab"
$Host2 = "esx-02b.site-b.vcf.lab"
$Cluster = "cluster-mgmt-01b"
$vcVM = "vc-mgmt-b"
$nsxVM = "nsx-mgmt-01b"

}

Else {exit}


Connect-VIServer $vCenter -User administrator@vsphere.local -Password VMware123!VMware123!

# Create Host Groups
New-DrsClusterGroup -Name "Host1" -Cluster $Cluster -VMHost $Host1
New-DrsClusterGroup -Name "Host2" -Cluster $Cluster -VMHost $Host2

# Create VM Groups
New-DrsClusterGroup -Name "vCenter" -Cluster $Cluster -VM $vcVM
New-DrsClusterGroup -Name "NSX" -Cluster $Cluster -VM $nsxVM


# Create DRS Rules
New-DrsVMHostRule -Name "Pin vCenter" -Cluster $Cluster -VMHostGroup "Host1" -VMGroup "vCenter" -Type ShouldRunOn -Enabled:$true
New-DrsVMHostRule -Name "Pin NSX" -Cluster $Cluster -VMHostGroup "Host2" -VMGroup "NSX" -Type ShouldRunOn -Enabled:$true

# Set DRS Threshold to Conservative
$DRSCluster = Get-Cluster -Name $Cluster | Get-View
$DRSclusSpec = New-Object VMware.Vim.ClusterConfigSpecEx
$DRSclusSpec.drsConfig = New-Object VMware.Vim.ClusterDrsConfigInfo
$DRSclusSpec.drsConfig.vmotionRate = "4"
$DRSCluster.ReconfigureComputeResource_Task($DRSclusSpec, $true)

# Finished - Disconnect
Disconnect-VIServer $vCenter -Confirm:$false




