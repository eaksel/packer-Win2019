# packer-Win2019

## What is packer-Win2019 ?

packer-Win2019 is a set of configuration files used to build automated Windows Server 2019 virtual machine images using [Packer](https://www.packer.io/).
This Packer configuration file allows you to build images for VMware Workstation and Oracle VM VirtualBox.

## Prerequisites

* [Packer](https://www.packer.io/downloads.html)
  * <https://www.packer.io/intro/getting-started/install.html>
* A Hypervisor
  * [VMware Workstation](https://www.vmware.com/products/workstation-pro.html)
  * [Oracle VM VirtualBox](https://www.virtualbox.org/)

## How to use Packer

Commands to create an automated VM image:

To create a Windows Server 2019 VM image using VMware Workstation use the following commands:

```sh
cd c:\packer-Win2019
packer build -only=vmware-iso win2019-gui.json #Windows Server 2019 w/ GUI
packer build -only=vmware-iso win2019-core.json #Windows Server 2019 Core
```

To create a Windows Server 2019 VM image using Oracle VM VirtualBox use the following commands:

```sh
cd c:\packer-Win2019
packer build -only=virtualbox-iso win2019-gui.json #Windows Server 2019 w/ GUI
packer build -only=virtualbox-iso win2019-core.json #Windows Server 2019 Core
```

*If you omit the keyword "-only=" images for both Workstation and Virtualbox will be created.*

By default the .iso of Windows Server 2019 is pulled from <https://software-download.microsoft.com/download/pr/17763.1.180914-1434.rs5_release_SERVER_EVAL_X64FRE_EN-US.ISO>

You can change the URL to one closer to your build server. To do so change the **"iso_url"** parameter in the **"variables"** section of the debian9.json file.

```json
{
  "variables": {
      "iso_url": "https://software-download.microsoft.com/download/pr/17763.1.180914-1434.rs5_release_SERVER_EVAL_X64FRE_EN-US.ISO"
  }
}
```

## Default credentials

The default credentials for this VM image are:

|Username|Password|
|--------|--------|
|packer|packer|
|administrator|packer|