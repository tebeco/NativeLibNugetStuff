Write-Host 'Running ThirdPart build script' -ForegroundColor Blue
./ThirdPart/build.ps1

Write-Host 'Running Common lib build script' -ForegroundColor Blue
./Corp.Common/build.ps1

Write-Host 'Running Consumer build script' -ForegroundColor Blue
./Corp.FeatureTeam/build.ps1
