# NativeLibNugetStuff

This is an example .NET solution that shows how to bundle a native library inside a NuGet package. The solution contains the following parts:

- A `ThirdPart` folder mimicking what our `Third part vendor` send us in a ... `zip` containing raw dll
  You have to build that folder to get an equivalent of what they do send (we do not send us their sources)  
  They explicitly refused to `pack` as a nuget => so we just have `raw dll` (the `./build.ps1` of this force is supposed to produce these dll in the `lib` folder)
  - A native library named `third-part-native`), written in Rust, that exports a function.
  - A .NET wrapper library named `ThirdPart.ManagedWrapper` that consumes that native library, and is published as ... RAW DLL (that code contains `DllImport`).
- A `Corp.Common` folder mimicking a mono-repo of "libraries" versionned / packed / published as nuget all together
  - A .Net library named `Corp.Common.ThirdPartPackaged` (note that `PusblishBuildOutput` is set to `false`) that just contains `<Pack .../>` in the `csproj` to pack Dll from the vendor
  - A .NET library named `Corp.Common.Lib` that consumes the `Corp.Common.ThirdPartPackaged` library NuGet, and is also published as a NuGet package. <===== THIS IS where the issue will be
  - A .NET Core console application that serves as a sample to debug that part of the mono repo, it consumes the `Corp.Common.Lib` `csprok`, not the NuGet and should not know about what's behind
- A Folder `Corp.FeatureTeam` mimicking what/how teams do
  - A .NET Core console application consumming `Corp.Common.Lib` as a Nuget

## Build

### Prerequisites

- .NET Core `5.0-preview3` (change `<TargetFramework>` that are set to `net5.0` to `netcoreapp3.1` if you want to build against `dotnet 3.1.201`)
- A current Rust/Cargo compiler toolchain to build the native library.

To build and execute the `Corp.FeatureTeam`, just runs `./build.ps1` in PowerShell. The script will automatically build and package the projects in the right order, and finally run the consumer application.

## Issue

[if you take a look here :](https://github.com/tebeco/NativeLibNugetStuff/blob/master/Corp.Common/src/Corp.Common.Lib/Corp.Common.Lib.csproj#L8-L11)
The `Corp.Common.Lib` is reference a project from the same solution ... using a `PackageReference` which is far from good 
```xml
  <ItemGroup>
    <PackageReference Include="Corp.Common.ThirdPartPackaged" Version="*" />
    <!--<ProjectReference Include="../Corp.Common.ThirdPartPackaged/Corp.Common.ThirdPartPackaged.csproj" />-->
  </ItemGroup>
```
It means that if you did not first did a `dotnet pack` on `Corp.Common.ThirdPartPackaged` => you're doomed

I'm looking for a way to tell `dotnet` to use the `ProjectReference` like this:
```xml
  <ItemGroup>
    <ProjectReference Include="../Corp.Common.ThirdPartPackaged/Corp.Common.ThirdPartPackaged.csproj" />
  </ItemGroup>
```