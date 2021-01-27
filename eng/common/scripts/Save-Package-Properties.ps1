[CmdletBinding()]
Param (
  [Parameter(Mandatory=$True)]
  [string] $serviceName,
  [Parameter(Mandatory=$True)]
  [string] $OutDirectory
)

. (Join-Path $PSScriptRoot common.ps1)
$allPackageProperties = Get-AllPkgProperties $serviceName
if ($allPackageProperties)
{
    New-Item -ItemType Directory -Force -Path $OutDirectory
    foreach($pkg in $allPackageProperties)
    {
        Write-Host "Package Name: $($pkg.Name)"
        Write-Host "Package Version: $($pkg.Version)"
        Write-Host "Package SDK Type: $($pkg.SdkType)"
        $outputPath = Join-Path -Path $OutDirectory ($pkg.Name + ".json")
        $outputObject = $pkg | ConvertTo-Json
        Set-Content -Path $outputPath -Value $outputObject
    }

    Get-ChildItem -Path $OutDirectory
}
else
{
    Write-Host "Package properties are not available for service directory $($serviceName)"
    exit(1)
}
