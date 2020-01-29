$ProgressPreference = "SilentlyContinue"
$package = "VMware-tools-11.0.5-15389592-x86_64.exe"
$url = "https://packages.vmware.com/tools/releases/11.0.5/windows/x64/$package"
$exe = "$Env:TEMP\$package"

Write-Output "***** Downloading VMware Tools"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $exe)

$parameters = '/S /v "/qn REBOOT=R ADDLOCAL=ALL"'

Write-Output "***** Installing VMware Tools"
Start-Process $exe $parameters -Wait

Write-Output "***** Deleting $exe"
Remove-Item $exe