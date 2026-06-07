$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    $scriptUrl = "https://raw.githubusercontent.com/yadavnikhil03/asus_driver/main/start.ps1"
    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm '$scriptUrl' | iex`"" -Verb RunAs
    return
}

$repo = "https://raw.githubusercontent.com/yadavnikhil03/asus_driver/main"
$dir  = "$env:TEMP\asus_driver"

New-Item -ItemType Directory -Path $dir -Force | Out-Null

irm "$repo/install_drivers.ps1" -OutFile "$dir\install_drivers.ps1"
irm "$repo/drivers.json"        -OutFile "$dir\drivers.json"

& "$dir\install_drivers.ps1"

Remove-Item -Path $dir -Recurse -Force -ErrorAction SilentlyContinue
