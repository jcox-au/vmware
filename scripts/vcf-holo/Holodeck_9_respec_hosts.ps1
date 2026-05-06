Import-Module VCF.PowerCLI

$vCenter = "vcenter.lab.home"
$Site = "b"
$InstanceID = "red"
$cpuSpec = "24"
$memSpec = "128"

Connect-VIServer $vCenter

Set-VM -VM "$InstanceID-esx01b" -NumCpu $cpuSpec -MemoryGB $memSpec -RunAsync -Confirm:$false
Set-VM -VM "$InstanceID-esx02b" -NumCpu $cpuSpec -MemoryGB $memSpec -RunAsync -Confirm:$false
Set-VM -VM "$InstanceID-esx03b" -NumCpu $cpuSpec -MemoryGB $memSpec -RunAsync -Confirm:$false
Set-VM -VM "$InstanceID-esx04b" -NumCpu $cpuSpec -MemoryGB $memSpec -RunAsync -Confirm:$false
