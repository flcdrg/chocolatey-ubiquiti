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

Install-ChocolateyPackage @packageArgs