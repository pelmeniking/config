########## BASIC RUNTIME SETTINGS ##########

# Modern TLS
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls13

# UTF-8 everywhere
[console]::InputEncoding  = [System.Text.UTF8Encoding]::new()
[console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

########## ENVIRONMENT ##########

$env:AZ_ENABLED = $false
$repos = Join-Path $HOME 'repos'

########## STARSHIP INIT ##########

if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (& starship init powershell)
}

########## MODULES ##########

# PSReadLine (ohne problematischen Parameter)
if (Get-Module -ListAvailable -Name PSReadLine) {
    Import-Module PSReadLine

    # Base settings
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle InlineView
    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineOption -BellStyle None

    # Keybindings
    Set-PSReadLineKeyHandler -Key Ctrl+p -Function PreviousHistory
    Set-PSReadLineKeyHandler -Key Ctrl+n -Function NextHistory
    Set-PSReadLineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory
}

# Devdeer CAF (nur wenn installiert)
if (Get-Module -ListAvailable -Name Devdeer.caf) {
    Import-Module Devdeer.caf
}

########## FUNCTIONS ##########

# eza-based ls-family (fallback to Get-ChildItem)
if (Get-Command eza -ErrorAction SilentlyContinue) {
    function lsx { eza -1l --icons always --group-directories-first }
    function lsa { eza -1l --icons always --group-directories-first --show-symlinks -a }
} else {
    function lsx { Get-ChildItem }
    function lsa { Get-ChildItem -Force }
}

# Hydra project locator
function hydra($name) {
    $dirs = Get-ChildItem "$repos/Hydra/infrastructure" -Recurse -Filter "*$name*" -Depth 5 |
            Where-Object { $_.PsIsContainer -eq $true }

    if ($dirs.Length -eq 0) { return }

    Set-Location $dirs[0]
}

# CAF-wrapper (with safety check)
function caf($cmd) {
    if (Get-Command Start-CafScoped -ErrorAction SilentlyContinue) {
        Start-CafScoped -Command $cmd
    } else {
        Write-Warning "Start-CafScoped / Devdeer.caf nicht verfügbar."
    }
}

# Simple AD login info
function Get-ADLogonInfo {
    [PSCustomObject]@{
        Benutzer    = $env:USERNAME
        Domain      = $env:USERDOMAIN
        LogonServer = $env:LOGONSERVER
    }
}

# Process top (CPU heavy)
function top {
    Get-Process |
        Sort-Object CPU -Descending |
        Select-Object -First 15 |
        Format-Table -Auto
}

# Git graph
function glog {
    git log --graph --oneline --decorate --all
}

# Quick jump to repos
function cdr { Set-Location $repos }

# Project jump
function cproj([string]$name) {
    $target = Get-ChildItem -Path $repos -Directory -Recurse -Depth 2 |
              Where-Object { $_.Name -like "*$name*" } |
              Select-Object -First 1

    if ($null -ne $target) {
        Set-Location $target.FullName
    } else {
        Write-Host "Kein Projekt gefunden zu '$name' unter $repos." -ForegroundColor DarkYellow
    }
}

########## ALIASES ##########

Set-Alias gg glog
Set-Alias -Name ls       -Value lsx
Set-Alias -Name nslookup -Value Resolve-DnsName
Set-Alias -Name netuse   -Value Get-SmbMapping
Set-Alias -Name cat      -Value Get-Content

# Hyper alias (nur wenn Program existiert)
if (Test-Path "$env:LOCALAPPDATA\Programs\Hyper\Hyper.exe") {
    Set-Alias hyper "$env:LOCALAPPDATA\Programs\Hyper\Hyper.exe"
}
