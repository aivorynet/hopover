# Build an unsigned MSIX of dist\Hopover.exe for the Microsoft Store. Partner Center signs it on upload.
# Usage: .\build.ps1; packaging\msix\build-msix.ps1 -Version 1.1.0
#        packaging\msix\build-msix.ps1 -Version 1.1.0 -Register   # also register the folder on this PC (Developer Mode)
param(
  [Parameter(Mandatory)] [string] $Version,
  # Values from Partner Center > Hopover > Product identity (AIVory, Inc. account, same publisher as AIVory Code).
  [string] $IdentityName = "AIVoryInc.Hopover",
  [string] $Publisher = "CN=1E786547-45C5-4CB8-8218-99D720EF3558",
  [string] $PublisherDisplay = "AIVory, Inc.",
  [switch] $Register
)
$ErrorActionPreference = "Stop"
$root = Resolve-Path "$PSScriptRoot\..\.."
$dist = Join-Path $root 'dist'
$exe = Join-Path $dist 'Hopover.exe'
if (-not (Test-Path $exe)) { throw "$exe missing. Run .\build.ps1 first." }

$sdk = Get-ChildItem "${env:ProgramFiles(x86)}\Windows Kits\10\bin\*\x64\makeappx.exe" | Sort-Object FullName | Select-Object -Last 1
if (-not $sdk) { throw "makeappx.exe not found. Install the Windows SDK." }

$stage = Join-Path $dist 'msix-stage'
if (Test-Path $stage) { Remove-Item -Recurse -Force $stage }
New-Item -ItemType Directory -Force "$stage\Assets" | Out-Null
Copy-Item $exe $stage

# Logos from the Logo DrawingImage in Theme.xaml (the same mark as the .ico).
Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Xaml
$app = Join-Path $root 'app'
$xaml = (Get-Content (Join-Path $app 'Theme.xaml') -Raw -Encoding UTF8).Replace('@FONTDIR@', ([Uri](Join-Path $app 'fonts\')).AbsoluteUri)
$theme = [Windows.Markup.XamlReader]::Parse($xaml)
function Save-Logo([string] $name, [int] $w, [int] $h, [int] $mark) {
    $logo = if ($mark -le 32) { $theme['LogoIcon24'] } else { $theme['LogoIcon'] }
    $dv = New-Object Windows.Media.DrawingVisual
    $dc = $dv.RenderOpen()
    $dc.DrawImage($logo, (New-Object Windows.Rect ([math]::Floor(($w - $mark) / 2)), ([math]::Floor(($h - $mark) / 2)), $mark, $mark))
    $dc.Close()
    $bmp = New-Object Windows.Media.Imaging.RenderTargetBitmap $w, $h, 96, 96, ([Windows.Media.PixelFormats]::Pbgra32)
    $bmp.Render($dv)
    $enc = New-Object Windows.Media.Imaging.PngBitmapEncoder
    $enc.Frames.Add([Windows.Media.Imaging.BitmapFrame]::Create($bmp))
    $fs = [IO.File]::Create((Join-Path "$stage\Assets" $name)); $enc.Save($fs); $fs.Close()
}
Save-Logo 'StoreLogo.png' 50 50 50
Save-Logo 'Square44x44Logo.png' 44 44 44
Save-Logo 'Square44x44Logo.targetsize-256.png' 256 256 256
Save-Logo 'Square150x150Logo.png' 150 150 120
Save-Logo 'Wide310x150Logo.png' 310 150 120
Save-Logo 'StoreLogo300.png' 300 300 300

# MSIX versions have four parts; the Store wants the last one 0.
(Get-Content "$PSScriptRoot\AppxManifest.xml" -Raw).
  Replace('{{IDENTITY_NAME}}', $IdentityName).
  Replace('{{PUBLISHER}}', [Security.SecurityElement]::Escape($Publisher)).
  Replace('{{PUBLISHER_DISPLAY}}', [Security.SecurityElement]::Escape($PublisherDisplay)).
  Replace('{{VERSION}}', "$Version.0") | Set-Content -Encoding UTF8 "$stage\AppxManifest.xml"

$out = Join-Path $dist "Hopover-$Version.msix"
& $sdk.FullName pack /o /d $stage /p $out | Out-Host
if ($LASTEXITCODE) { throw 'makeappx failed' }
Write-Host "MSIX: $out"

if ($Register) {
    Add-AppxPackage -Register (Join-Path $stage 'AppxManifest.xml')
    Write-Host "Registered $IdentityName from $stage (remove: Get-AppxPackage $IdentityName | Remove-AppxPackage)"
}
