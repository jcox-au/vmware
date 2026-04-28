# Script to set all VMs in the vApp to Group1 / Shutdown Settings

Import-Module VCF.PowerCLI

# Set vApp Name
$vAppName = "vcf9-green-b"

# Set Host vCenter
$vCenter = "vcenter.lab.home"

Connect-VIServer $vCenter

# Set All VMs to Group 1 / Shutdown / Timeout / Waiting etc.
$vApp = Get-VApp -Name $vAppName
$spec = New-Object VMware.Vim.VAppConfigSpec
$spec.EntityConfig = $vApp.ExtensionData.VAppConfig.EntityConfig

foreach($key in $spec.EntityConfig){

    $spec.EntityConfig |  %{

        $_.StartOrder = "1"
        $_.WaitingForGuest = "True"
        $_.StopAction = "guestShutdown"
        $_.StopDelay = "360"

    }

}

# Apply Settings
$vapp.ExtensionData.UpdateVAppConfig($spec)

Disconnect-VIServer $vCenter -Confirm:$false