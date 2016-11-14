# Install ScaleFT Server Tools
# Since there's no enrollment token or local configuration,
# expect a cloud account integration to determine enrollment

$installer_url = "https://dist.scaleft.com/server-tools/windows/latest/ScaleFT-Server-Tools-latest.msi"
$installer_path = [System.IO.Path]::ChangeExtension([System.IO.Path]::GetTempFileName(), ".msi")
(New-Object System.Net.WebClient).DownloadFile($installer_url, $installer_path)
Write-Output (Get-Item($installer_path))
msiexec.exe /qb /I $installer_path
