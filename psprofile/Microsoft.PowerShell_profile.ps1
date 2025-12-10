[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls13
[console]::InputEncoding = [console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
# MOTD beim Start anzeigen
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Current User:       $($env:USERNAME)" -ForegroundColor Green
Write-Host "Domain:             $($env:USERDOMAIN).com" -ForegroundColor Green
Write-Host "LogonServer:        $($env:LOGONSERVER)" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Cyan
#env
$env:AZ_ENABLED = $false
$repos = Join-Path $HOME 'repos'   # ergibt z.B. C:\Users\thomas.appelt\repos
Invoke-Expression (&starship init powershell --print-full-init | Out-String)
# Import Module
Import-Module Devdeer.caf
Import-Module PSReadLine
# Bessere History / Autosuggest
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView
function Invoke-Starship-PreCommand {
  $loc = $executionContext.SessionState.Path.CurrentLocation;
  $prompt = "$([char]27)]9;12$([char]7)"
  if ($loc.Provider.Name -eq "FileSystem")
  {
    $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $host.ui.Write($prompt)
}
#Functions
function lsx() {eza -1l --icons always  --group-directories-first}
function lsa() {eza -1l --icons always  --group-directories-first --show-symlinks -a}
function hydra($name) {
    $dirs = Get-ChildItem "$repos/Hydra/infrastructure" -Recurse -Filter "*$name*" -Depth 5 | Where-Object { $_.PsIsContainer -eq $true }
    if ($dirs.Length -eq 0) {
        return
    }
    Set-Location $dirs[0]
}
 function caf($cmd) {Start-CafScoped -Command $cmd}
function Get-ADLogonInfo {
    [PSCustomObject]@{
        Benutzer    = $env:USERNAME
        Domain      = $env:USERDOMAIN
        LogonServer = $env:LOGONSERVER
    }
}
function top { Get-Process | Sort-Object CPU -Descending | Select-Object -First 15 | Format-Table -Auto }
#Alias
Set-Alias -Name ls -Value lsx
Set-Alias -Name nslookup -Value Resolve-DnsName
Set-Alias netuse Get-SmbMapping
Set-Alias cat Get-Content
Set-Alias hyper "$env:LOCALAPPDATA\Programs\Hyper\Hyper.exe"