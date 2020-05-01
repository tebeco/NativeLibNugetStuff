Write-Host 'Publishing Corp.FeatureTeam.Host' -ForegroundColor Cyan
dotnet publish "$($PSScriptRoot)/Corp.FeatureTeam.Host/" --configuration Release --self-contained --runtime win10-x64

Write-Host 'Running published Corp.FeatureTeam.Host' -ForegroundColor Cyan
. "$($PSScriptRoot)\Corp.FeatureTeam.Host\bin\Release\net5.0\win10-x64\publish\Corp.FeatureTeam.Host.exe"
