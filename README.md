# packer-Win2019

## What is packer-Win2019 ?

packer-Win2019 is a set of configuration files used to build automated Windows Server 2019 virtual machine images using [Packer](https://www.packer.io/).
This Packer configuration file allows you to build images for VMware Workstation and Oracle VM VirtualBox.

## Prerequisites

- [Packer](https://www.packer.io/downloads.html)
  - <https://www.packer.io/intro/getting-started/install.html>
- A Hypervisor
  - [VMware Workstation](https://www.vmware.com/products/workstation-pro.html)
  - [Oracle VM VirtualBox](https://www.virtualbox.org/)

## How to use Packer

Commands to create an automated VM image:

To create a Windows Server 2019 VM image using VMware Workstation use the following commands:

```sh
cd c:\packer-Win2019
packer build -only=vmware-iso win2019-gui.json #Windows Server 2019 w/ GUI
packer build -only=vmware-iso win2019-core.json #Windows Server 2019 Core
packer build -only=vmware-iso win2019-gui_uefi.json #Windows Server 2019 w/ GUI using UEFI
packer build -only=vmware-iso win2019-core_uefi.json #Windows Server 2019 Core using UEFI
```

To create a Windows Server 2019 VM image using Oracle VM VirtualBox use the following commands:

```sh
cd c:\packer-Win2019
packer build -only=virtualbox-iso win2019-gui.json #Windows Server 2019 w/ GUI
packer build -only=virtualbox-iso win2019-core.json #Windows Server 2019 Core
packer build -only=virtualbox-iso win2019-gui_uefi.json #Windows Server 2019 w/ GUI using UEFI
packer build -only=virtualbox-iso win2019-core_uefi.json #Windows Server 2019 Core using UEFI
```

*If you omit the keyword "-only=" images for both Workstation and Virtualbox will be created.*

By default the .iso of Windows Server 2019 is pulled from <https://software-download.microsoft.com/download/pr/17763.1.180914-1434.rs5_release_SERVER_EVAL_X64FRE_EN-US.ISO>

You can change the URL to one closer to your build server. To do so change the **"iso_url"** parameter in the **"variables"** section of the win2019-*.json file.

```json
{
  "variables": {
      "iso_url": "https://software-download.microsoft.com/download/pr/17763.1.180914-1434.rs5_release_SERVER_EVAL_X64FRE_EN-US.ISO"
  }
}
```

## Configuring Input/User Locale & Timezone

To set the input/user locale and timezone according to your preferences edit the following files:

- ".\packer-Win2019\scripts\<bios|uefi>\core\autounattend.xml"
- ".\packer-Win2019\scripts\<bios|uefi>\gui\autounattend.xml"

```xml
<settings pass="specialize">
    <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-International-Core" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
        <InputLocale>fr-FR</InputLocale>
        <UserLocale>fr-FR</UserLocale>
    </component>
    <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
        <TimeZone>Romance Standard Time</TimeZone>
    </component>
</settings>
```

## Default credentials

The default credentials for this VM image are:

|Username|Password|
|--------|--------|
|administrator|packer|
