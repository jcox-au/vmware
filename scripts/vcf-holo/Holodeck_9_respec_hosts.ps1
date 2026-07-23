Import-Module VCF.PowerCLI

$vCenter = "vcenter.lab.home"
$siteID = "a
$instanceID = "red"
$cpuSpec = "24"
$memSpec = "128"

Connect-VIServer $vCenter
$hostStr = "$instanceID-esx01" + "$siteID"

Set-VM -VM "blue-esx-01b" -NumCpu $cpuSpec -MemoryGB $memSpec -RunAsync -Confirm:$false
Set-VM -VM "blue-esx-02b" -NumCpu $cpuSpec -MemoryGB $memSpec -RunAsync -Confirm:$false
Set-VM -VM "blue-esx-03b" -NumCpu $cpuSpec -MemoryGB $memSpec -RunAsync -Confirm:$false
Set-VM -VM "blue-esx-04b" -NumCpu $cpuSpec -MemoryGB $memSpec -RunAsync -Confirm:$false
