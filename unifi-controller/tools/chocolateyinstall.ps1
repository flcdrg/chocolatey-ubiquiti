$ErrorActionPreference = 'Stop';

$packageName= 'unifi-controller'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl.ubnt.com/unifi/5.3.8/UniFi-installer.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Ubiquiti UniFi*'
  checksum      = '3C4521FF0CC68FF8D7FACD50780F331BF19DF7514988AF128D8F6821AF109FE8'
  checksumType  = 'sha256'
  silentArgs   = '/S'
  validExitCodes= @(0)
}

# Configure firewall for UniFi - from https://community.ubnt.com/t5/UniFi-Wireless/UniFi-AP-firewall-settings-for-Windows-Server-2012-R2/td-p/1090855
New-NetFirewallRule -Name UniFi-Mgmt-In -DisplayName "UniFi-Mgmt (TCP-In 8081)" -Description "Allows incoming UniFi management traffic" -Group UniFi -Enabled True -Protocol TCP -LocalPort 8081 -Direction Inbound
New-NetFirewallRule -Name UniFi-Mgmt-Out -DisplayName "UniFi-Mgmt (TCP-Out 8081)" -Description "Allows outgoing UniFi management traffic" -Group UniFi -Enabled True -Protocol TCP -LocalPort 8081 -Direction Outbound
New-NetFirewallRule -Name UniFi-DvcInfrm-In -DisplayName "UniFi-DvcInfrm (TCP-In 8080)" -Description "Allows incoming UniFi device inform traffic" -Group UniFi -Enabled True -Protocol TCP -LocalPort 8080 -Direction Inbound
New-NetFirewallRule -Name UniFi-DvcInfrm-Out -DisplayName "UniFi-DvcInfrm (TCP-Out 8080)" -Description "Allows outgoing UniFi device inform traffic" -Group UniFi -Enabled True -Protocol TCP -LocalPort 8080 -Direction Outbound
New-NetFirewallRule -Name UniFi-Ctrlr-In -DisplayName "UniFi-Ctrlr (TCP-In 8443)" -Description "Allows incoming UniFi Controller traffic" -Group UniFi -Enabled True -Protocol TCP -LocalPort 8443 -Direction Inbound
New-NetFirewallRule -Name UniFi-Ctrlr-Out -DisplayName "UniFi-Ctrlr (TCP-Out 8443)" -Description "Allows outgoing UniFi Controller traffic" -Group UniFi -Enabled True -Protocol TCP -LocalPort 8443 -Direction Outbound
New-NetFirewallRule -Name UniFi-PrtlRdr-In -DisplayName "UniFi-PrtlRdr (TCP-In 8880)" -Description "Allows incoming UniFi portal redirect traffic" -Group UniFi -Enabled True -Protocol TCP -LocalPort 8880 -Direction Inbound
New-NetFirewallRule -Name UniFi-PrtlRdr-Out -DisplayName "UniFi-PrtlRdr (TCP-Out 8880)" -Description "Allows outgoing UniFi portal redirect traffic" -Group UniFi -Enabled True -Protocol TCP -LocalPort 8880 -Direction Outbound
New-NetFirewallRule -Name UniFi-PrtlRdrSsl-In -DisplayName "UniFi-PrtlRdrSsl (TCP-In 8843)" -Description "Allows incoming UniFi portal redirect for SSL traffic" -Group UniFi -Enabled True -Protocol TCP -LocalPort 8843 -Direction Inbound
New-NetFirewallRule -Name UniFi-PrtlRdrSsl-Out -DisplayName "UniFi-PrtlRdrSsl (TCP-Out 8843)" -Description "Allows outgoing UniFi portal redirect for SSL traffic" -Group UniFi -Enabled True -Protocol TCP -LocalPort 8843 -Direction Outbound
#New-NetFirewallRule -Name UniFi-DB-In -DisplayName "UniFi-DB (TCP-In 27117)" -Description "Allows incoming UniFi DB traffic" -Group UniFi -Enabled True -Protocol TCP -LocalPort 27117 -Direction Inbound
#New-NetFirewallRule -Name UniFi-DB-Out -DisplayName "UniFi-DB (TCP-Out 27117)" -Description "Allows outgoing UniFi DB traffic" -Group UniFi -Enabled True -Protocol TCP -LocalPort 27117 -Direction Outbound
New-NetFirewallRule -Name UniFi-DvcDisc-In -DisplayName "UniFi-DvcDisc (UDP-In 10001)" -Description "Allows incoming UniFi device discovery traffic" -Group UniFi -Enabled True -Protocol UDP -LocalPort 10001 -Direction Inbound
New-NetFirewallRule -Name UniFi-DvcDisc-Out -DisplayName "UniFi-DvcDisc (UDP-Out 10001)" -Description "Allows outgoing UniFi device discovery traffic" -Group UniFi -Enabled True -Protocol UDP -LocalPort 10001 -Direction Outbound

Install-ChocolateyPackage @packageArgs