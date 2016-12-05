# Install ScaleFT Server Tools
# altname is templated in from tf

Write-Output 'Writing Enrollment Token'
# Write the Enrollment Token
# This one is for the AWS reInvent Demo Project
$enrollment_token = "eyJzIjoiZGZjNmViMzYtZmYzZi00MDA0LTk2NzAtNWEzNDRhYzVhMWEyIiwidSI6Imh0dHBzOi8vYXBwLnNjYWxlZnQuY29tIn0="
$enrollment_token_path = "C:\windows\system32\config\systemprofile\AppData\Local\ScaleFT\enrollment.token"
New-Item -ItemType directory -Path (Split-Path $enrollment_token_path -Parent)
$enrollment_token | Out-File $enrollment_token_path -Encoding "ASCII"

Write-Output 'Writing ScaleFT config'
# Write sftd config file with an AltName set
$sftdcfg = @"
---
AltNames: ["${altname}"]
"@

Add-Content "C:\Windows\System32\config\systemprofile\AppData\Local\ScaleFT\sftd.yaml" $sftdcfg

Write-Output 'Installing ScaleFT MSI'
$installer_url = "https://dist.scaleft.com/server-tools/windows/latest/ScaleFT-Server-Tools-latest.msi"
$installer_path = [System.IO.Path]::ChangeExtension([System.IO.Path]::GetTempFileName(), ".msi")
(New-Object System.Net.WebClient).DownloadFile($installer_url, $installer_path)
Write-Output (Get-Item($installer_path))
msiexec.exe /qb /I $installer_path
