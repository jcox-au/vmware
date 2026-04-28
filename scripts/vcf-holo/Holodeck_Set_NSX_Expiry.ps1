# Script to set NSX Expiry to 9999 days

# Set Holodeck NSX Mgr
$HostName = "nsx-mgmt-b.site-b.vcf.lab"
$username = "admin"
$upassword = "VMware123!VMware123!"


# Prepare REST headers/auth
$auth = $username + ':' + $upassword
$Encoded = [System.Text.Encoding]::UTF8.GetBytes($auth)
$authorizationInfo = [System.Convert]::ToBase64String($Encoded)
$contentType = "application/json"
$headers = @{"Authorization"="Basic $($authorizationInfo)"}


# Prepare REST body for password expiry extension
$body = "{`"password_change_frequency`" : 9999}"

# Set Root User
Invoke-WebRequest -Uri "https://$($HostName)/api/v1/node/users/0" -Method PUT -Headers $headers -Body $body -ContentType $contentType
# Set Admin User
Invoke-WebRequest -Uri "https://$($HostName)/api/v1/node/users/10000" -Method PUT -Headers $headers -Body $body -ContentType $contentType
# Set Audit User
Invoke-WebRequest -Uri "https://$($HostName)/api/v1/node/users/10002" -Method PUT -Headers $headers -Body $body -ContentType $contentType


# Get List of Transport Node IDs, and filter for hostname edge*
$tnList = Invoke-RestMethod -Uri "https://$($HostName)/api/v1/transport-nodes/" -Method GET -Headers $headers -ContentType $contentType
$edgeNodes = $tnlist.results | Where-Object -Property "display_name" -like "edge*" | Select-Object "node_id"

#Set Password Policy for each user on each edge node
foreach($node_id in $edgeNodes){

# Set Root User
Invoke-WebRequest -Uri "https://$($HostName)/api/v1/transport-nodes/$($node_id.node_id)/node/users/0" -Method PUT -Headers $headers -Body $body -ContentType $contentType
# Set Admin User
Invoke-WebRequest -Uri "https://$($HostName)/api/v1/transport-nodes/$($node_id.node_id)/node/users/10000" -Method PUT -Headers $headers -Body $body -ContentType $contentType
# Set Audit User
Invoke-WebRequest -Uri "https://$($HostName)/api/v1/transport-nodes/$($node_id.node_id)/node/users/10002" -Method PUT -Headers $headers -Body $body -ContentType $contentType

}

