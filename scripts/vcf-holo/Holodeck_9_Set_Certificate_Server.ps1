# Script to set NSX Expiry to 9999 days

# Set Holodeck NSX Mgr
$HostName = "ops-a.site-a.vcf.lab"
$username = "admin"
$upassword = "VMware123!VMware123!"


# Prepare REST headers/auth
$contentType = "application/json"

# Prepare REST body for password expiry extension
$body = "{`"password`" : ""$upassword"", `"username`" : ""$username"" }"

# Get Access Token
$token = (ConvertFrom-Json (Invoke-WebRequest -Uri "https://$($HostName)/suite-api/api/auth/token/acquire" -Method POST -Body $body -ContentType $contentType -SkipCertificateCheck)).token

# Set Token in Header
$headers = @{"Authorization"="OpsToken $token"}

# Prepare JSON Body for Cert Services Config
$json = @"
{    "certificateAuthoritiesSpec": {
        "microsoftCertificateAuthoritySpec": {
            "secret": "VMware123!VMware123!",
            "serverUrl": "https://dc01.ad.home/certsrv",
            "templateName": "VMwareVCF",
            "username": "cert"
        }
    },
    "certificateAuthorityType": "MICROSOFT" }
"@

# 
Invoke-WebRequest -Uri "https://$($HostName)/suite-api/api/fleet-management/certificate-management/certificate-authorities" -Method PUT -Headers $headers -Body $json -ContentType $contentType -SkipCertificateCheck

