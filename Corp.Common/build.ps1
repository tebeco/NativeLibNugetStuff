Write-Host "Building Corp.Common" -ForegroundColor Blue
Write-Host "Copying third part binary to Corp.Common.ThirdPartPackaged" -ForegroundColor Cyan
Copy-Item "$($PSScriptRoot)/../ThirdPart/lib/third_part_native.dll" "$($PSScriptRoot)/src/Corp.Common.ThirdPartPackaged/"
Copy-Item "$($PSScriptRoot)/../ThirdPart/lib/ThirdPart.ManagedWrapper.dll" "$($PSScriptRoot)/src/Corp.Common.ThirdPartPackaged/"

$Major=[System.DateTime]::Now.ToString("yyyy")
$Minor=[System.DateTime]::Now.ToString("MMdd")
$Patch=[System.DateTime]::Now.ToString("HHmm")
$Revision=[System.DateTime]::Now.ToString("ss")
$Version="$($Major).$($Minor).$($Patch).$($Revision)"
Write-Host "Packaging Version $($Version)"


Write-Host "Building Corp.Common.ThirdPartPackaged" -ForegroundColor Cyan
dotnet pack "$($PSScriptRoot)/src/Corp.Common.ThirdPartPackaged/" -o "$($PSScriptRoot)/../nugets" /p:Version="$($Version)"

Write-Host "Building Corp.Common.Lib" -ForegroundColor Cyan
dotnet pack "$($PSScriptRoot)/src/Corp.Common.Lib/" -o "$($PSScriptRoot)/../nugets" /p:Version="$($Version)"
