$ProgressPreference = "SilentlyContinue"

$webclient = New-Object System.Net.WebClient
$version_url = "http://download.virtualbox.org/virtualbox/LATEST.TXT"
$version = $webclient.DownloadString($version_url) -replace '\s', ''
$package = "VBoxGuestAdditions_$version.iso"
$url = "http://download.virtualbox.org/virtualbox/$version/$package"

Write-Output "***** Downloading Oracle VM VirtualBox Guest Additions"
$iso = "$Env:TEMP\$package"
$webclient.DownloadFile($url, $iso)

Write-Output "***** Mounting disk image at $iso"
Mount-DiskImage -ImagePath $iso

Write-Output "***** Installing VirtualBox Certificates"
$certdir = ((Get-DiskImage -ImagePath $iso | Get-Volume).Driveletter + ':\cert\')
$VBoxCertUtil = ($certdir + 'VBoxCertUtil.exe')
Get-ChildItem $certdir *.cer | ForEach-Object { & $VBoxCertUtil add-trusted-publisher $_.FullName --root $_.FullName }

Write-Output "***** Installing VirtualBox Guest Additions"
$exe = ((Get-DiskImage -ImagePath $iso | Get-Volume).Driveletter + ':\VBoxWindowsAdditions.exe')
$parameters = '/S'

Start-Process $exe $parameters -Wait

Write-Output "***** Dismounting & Deleting $iso"
Dismount-DiskImage -ImagePath $iso
Remove-Item $iso