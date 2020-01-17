$ProgressPreference = "SilentlyContinue"
$package = "VBoxGuestAdditions_6.1.2.iso"
$url = "http://download.virtualbox.org/virtualbox/6.1.2/$package"

Write-Output "***** Oracle VM VirtualBox Guest Additions"
Invoke-WebRequest $url -UseBasicParsing -OutFile "C:\Windows\Temp\$package"

$iso = "C:\Windows\Temp\$package"

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