# Script to set all VMs in the Holodeck Env - Disable Encrypted vMotion (Performance)

Import-Module VMware.PowerCLI

# Set Host vCenter
# $vCenter = "vcenter.lab.home"
$vCenter = "vcenter.lab.home"
# $vCenter = "vcenter-mgmt.vcf2.sddc.lab"

Connect-VIServer $vCenter

$VMView = Get-VM |Where "Name" -notlike 'VCLS*' | Get-View
                    $Config = New-Object VMware.Vim.VirtualMachineConfigSpec
                    $Config.MigrateEncryption = New-Object VMware.Vim.VirtualMachineConfigSpecEncryptedVMotionModes
                    $Config.MigrateEncryption = "disabled"
            $VMView.ReconfigVM($Config)

Disconnect-VIServer $vCenter -Confirm:$false
