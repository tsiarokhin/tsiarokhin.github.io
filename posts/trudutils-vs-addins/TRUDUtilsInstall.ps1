$repo = "TrudAX/TRUDUtilsD365"
$releases = "https://api.github.com/repos/$repo/releases"
$path = "C:\Temp\TRUDUtils"

If(!(test-path $path))
{
    New-Item -ItemType Directory -Force -Path $path
}
cd $path

Write-Host Determining latest release
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$tag = (Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name

$files = @("InstallToVS.exe",  "TRUDUtilsD365.dll",  "TRUDUtilsD365.pdb")

Write-Host Downloading files
foreach ($file in $files) 
{
    $download = "https://github.com/$repo/releases/download/$tag/$file"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest $download -Out $file
    Unblock-File $file
}
Start-Process "InstallToVS.exe" -Verb runAs