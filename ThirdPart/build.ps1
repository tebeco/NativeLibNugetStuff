Write-Host "ThirdPart Stuff" -ForegroundColor Blue

Write-Host "Cleaning pre-existing artifacts" -ForegroundColor Cyan
if (Test-Path -Path "$($PSScriptRoot)/lib" -PathType Container) {
    Remove-Item -Recurse -Force "$($PSScriptRoot)/lib"
}

if (Test-Path -Path "$($PSScriptRoot)/src/third-part-native/target" -PathType Container) {
    Remove-Item -Recurse -Force "$($PSScriptRoot)/src/third-part-native/target"
}

Write-Host "Building thirdparth native library (Rust)" -ForegroundColor Cyan
cargo build --manifest-path="$($PSScriptRoot)/src/third-part-native/Cargo.toml" --release

Write-Host "Building thirdparth managed wrapper(CSharp)" -ForegroundColor Cyan
dotnet build "$($PSScriptRoot)/src/ThirdPart.ManagedWrapper/ThirdPart.ManagedWrapper.csproj" -c Release -v:m

###
Write-Host "Copying ThirdPart build output to $($PSScriptRoot)/lib" -ForegroundColor Cyan

if (-not (Test-Path "$($PSScriptRoot)/lib"-PathType Container)) {
    New-Item -ItemType Container "$($PSScriptRoot)/lib"  | Out-Null
}

Copy-Item "$($PSScriptRoot)/src/third-part-native/target/release/third_part_native.dll" "$($PSScriptRoot)/lib/"
Copy-Item "$($PSScriptRoot)/src/ThirdPart.ManagedWrapper/bin/Release/netstandard2.0/ThirdPart.ManagedWrapper.dll" "$($PSScriptRoot)/lib/"
