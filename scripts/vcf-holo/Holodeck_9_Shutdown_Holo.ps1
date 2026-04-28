# Script to shutdown Holodeck

Import-Module VCF.PowerCLI


Connect-VIServer "vc-mgmt-a.site-a.vcf.lab"
  Stop-VMGuest -VM "edge-mgmt-01a" -Confirm:$false
  Stop-VMGuest -VM "edge-mgmt-02a" -Confirm:$false
  Stop-VMGuest -VM "opscollector-01a" -Confirm:$false
  Stop-VMGuest -VM "opslcm-a" -Confirm:$false
  Stop-VMGuest -VM "sddcmanager-a" -Confirm:$false
  Stop-VMGuest -VM "ops-a" -Confirm:$false
  Stop-VMGuest -VM "nsx-mgmt-01a" -Confirm:$false
  Sleep 20
  Stop-VMGuest -VM "vc-mgmt-a" -RunAsync -Confirm:$false
Disconnect-VIServer * -Confirm:$false



# Site-B
Connect-VIServer "vc-mgmt-b.site-b.vcf.lab"
  Stop-VMGuest -VM "edge-mgmt-01b" -Confirm:$false
  Stop-VMGuest -VM "edge-mgmt-02b" -Confirm:$false
  Stop-VMGuest -VM "opscollector-01b" -Confirm:$false
  Stop-VMGuest -VM "sddcmanager-b" -Confirm:$false
  Stop-VMGuest -VM "nsx-mgmt-01b" -Confirm:$false
  Sleep 20
  Stop-VMGuest -VM "vc-mgmt-b" -Confirm:$false
Disconnect-VIServer * -Confirm:$false


# Legacy-A

Connect-VIServer "vcenter-mgmt.vcf.sddc.lab"
  Stop-VMGuest -VM "edge1-mgmt" -Confirm:$false
  Stop-VMGuest -VM "edge2-mgmt" -Confirm:$false
  Stop-VMGuest -VM "vrli01a" -Confirm:$false
  Stop-VMGuest -VM "vrli01b" -Confirm:$false
  Stop-VMGuest -VM "vrli01c" -Confirm:$false
  Stop-VMGuest -VM "vrops01a" -Confirm:$false
  Stop-VMGuest -VM "vrops01b" -Confirm:$false
  Stop-VMGuest -VM "vrops-cp" -Confirm:$false
  Stop-VMGuest -VM "vrslcm" -Confirm:$false
  Stop-VMGuest -VM "ws1" -Confirm:$false
  Sleep 120
  Stop-VMGuest -VM "nsx-mgmt-1" -Confirm:$false
  Stop-VMGuest -VM "sddc-manager" -Confirm:$false
  Sleep 20
  Stop-VMGuest -VM "vcenter-mgmt" -Confirm:$false
Disconnect-VIServer * -Confirm:$false