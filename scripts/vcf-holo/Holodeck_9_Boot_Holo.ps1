# Script to boot Holodeck

Import-Module VCF.PowerCLI

function Wait-Count($s){
    do {
        Write-Progress -SecondsRemaining $s -Activity "Wait" -Status "Seconds remaining: " -Id 1
        $s--
        Start-Sleep -Seconds 1
    } until ($s -eq 0)
} 

#Site-A

Connect-VIServer esx-01a.site-a.vcf.lab -User root -Password VMware123!VMware123!
Start-VM "vc-mgmt-a"
Disconnect-VIServer * -Confirm:$false

Connect-VIServer esx-02a.site-a.vcf.lab -User root -Password VMware123!VMware123!
Start-VM "nsx-mgmt-01a"
Disconnect-VIServer * -Confirm:$false

Wait-Count 900

Connect-VIServer vc-mgmt-a.site-a.vcf.lab -User administrator@vsphere.local -Password VMware123!VMware123!
#Start-VM "nsx-mgmt-02a"
#Start-VM "nsx-mgmt-03a"
Start-VM "ops-a"
Start-VM "opscollector-01a"
Start-VM "license-a"
Get-VM | Where-Object -Property "Name" -Like "vsp*" | Start-VM
Start-VM "sddcmanager-a"
Start-VM "edge-mgmt-01a"
Start-VM "edge-mgmt-02a"
Disconnect-VIServer * -Confirm:$false


#Site-B

Connect-VIServer esx-01b.site-b.vcf.lab -User root -Password VMware123!VMware123!
Start-VM -VM "vc-mgmt-b"
Disconnect-VIServer * -Confirm:$false

Connect-VIServer esx-02b.site-b.vcf.lab -User root -Password VMware123!VMware123!
Start-VM "nsx-mgmt-01b"
Disconnect-VIServer * -Confirm:$false

Wait-Count 900

Connect-VIServer vc-mgmt-b.site-b.vcf.lab -User administrator@vsphere.local -Password VMware123!VMware123!
Start-VM "ops-b"
Start-VM "opscollector-01b"
Start-VM "license-b"
Get-VM | Where-Object -Property "Name" -Like "vsp*" | Start-VM
Start-VM "sddcmanager-b"
Start-VM "edge-mgmt-01b"
Start-VM "edge-mgmt-02b"
Disconnect-VIServer * -Confirm:$false


#Legacy

Connect-VIServer esxi-1.vcf.sddc.lab
Start-VM "vcenter-mgmt"
Disconnect-VIServer * -Confirm:$false

Connect-VIServer esxi-2.vcf.sddc.lab
Start-VM "nsx-mgmt-1"
Disconnect-VIServer * -Confirm:$false