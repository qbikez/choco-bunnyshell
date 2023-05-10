
$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/bunnyshell/cli/releases/download/v0.14.2/bns_0.14.2_Windows_i386.zip'
$url64      = 'https://github.com/bunnyshell/cli/releases/download/v0.14.2/bns_0.14.2_Windows_x86_64.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'bunnyshell*'

  checksum      = '392be55f00459cd7bdc8dfebe07cd1865b1dfed20dbb1de7bfd3bae81de2eff7'
  checksumType  = 'sha256'
  checksum64    = '3361fd2dc698b23d02989361444511ba894c1a48dac018a9b8aba2d775fc2e09'
  checksumType64= 'sha256'

}

Install-ChocolateyZipPackage @packageArgs

















