param([String]$folder_to_share = $PSScriptRoot)

Add-Type -AssemblyName System.IO.Compression.FileSystem

$sfz_link = "https://github.com/weihanglo/sfz/releases/download/v0.6.1/sfz-v0.6.1-x86_64-pc-windows-msvc.zip"
$sfz_zip = "$PSScriptRoot\sfz.zip"
$sfz_exe = "$PSScriptRoot\sfz.exe"

$ngrok_link = "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-windows-amd64.zip"
$ngrok_zip = "$PSScriptRoot\ngrok.zip"
$ngrok_exe = "$PSScriptRoot\ngrok.exe"

# sfz download
if (-not(Test-Path -Path $sfz_exe -PathType Leaf)) {
    Invoke-WebRequest -Uri $sfz_link -OutFile $sfz_zip

    [System.IO.Compression.ZipFile]::ExtractToDirectory($sfz_zip, $PSScriptRoot)

    Remove-Item $sfz_zip
}

# ngrok download
if (-not(Test-Path -Path $ngrok_exe -PathType Leaf)) {
    Invoke-WebRequest -Uri $ngrok_link -OutFile $ngrok_zip

    [System.IO.Compression.ZipFile]::ExtractToDirectory($ngrok_zip, $PSScriptRoot)

    Remove-Item $ngrok_zip
}

$port = 5032
Start-Process $sfz_exe ("-p", $port, $folder_to_share)
Start-Process $ngrok_exe ("http", $port)

# Troubleshooting
# 1.
# listen tcp 127.0.0.1:4049: bind: An attempt was made to access a socket in a way forbidden by its access permissions.
# run `net stop winnat`
