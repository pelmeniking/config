# ============================================================
#  PowerShell Profile – Fallout / ROBCO Terminal
#  User: thomas.appelt
# ============================================================

# --- Encoding ------------------------------------------------
[console]::InputEncoding  = [System.Text.UTF8Encoding]::new()
[console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

# --- TLS -----------------------------------------------------
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls13

# ============================================================
#  Helpers
# ============================================================

function Write-Type {
    param(
        [string]$Text,
        [int]$Delay = 12
    )
    foreach ($c in $Text.ToCharArray()) {
        Write-Host -NoNewline $c
        Start-Sleep -Milliseconds $Delay
    }
    Write-Host ""
}

# ============================================================
#  Fake CRT Scanlines (Boot Effect)
# ============================================================

function Show-ScanlinesBoot {
    param(
        [int]$Frames = 10,
        [int]$DelayMs = 30
    )

    if ($host.Name -match 'ISE') { return }

    $w = [Math]::Min([Console]::WindowWidth, 160)
    $h = [Math]::Min([Console]::WindowHeight, 30)

    $chars = @(' ', '░', '▒')
    $green = [ConsoleColor]::DarkGreen

    for ($f = 0; $f -lt $Frames; $f++) {
        [Console]::SetCursorPosition(0,0)

        for ($y = 0; $y -lt $h; $y++) {
            $isLine = ((($y + $f) % 3) -eq 0)
            if ($isLine) {
                [Console]::ForegroundColor = $green
                $fill = $chars[($f + $y) % $chars.Count]
                [Console]::Write(($fill * $w))
            }
            else {
                [Console]::Write((' ' * $w))
            }
            if ($y -lt ($h-1)) { [Console]::Write("`n") }
        }
        Start-Sleep -Milliseconds $DelayMs
    }

    [Console]::ResetColor()
    Clear-Host
}

# ============================================================
#  ROBCO INTRO (gekürzt, typed)
# ============================================================

if (-not $env:ROBCO_SHOWN) {
    $env:ROBCO_SHOWN = "1"

    # Toggle: $env:CRT="0" deaktiviert Scanlines
    if ($env:CRT -ne "0") {
        Show-ScanlinesBoot
    }

    Clear-Host
    $Host.UI.RawUI.ForegroundColor = "DarkGreen"

    Write-Type "ROBCO INDUSTRIES (TM) TERMLINK" 14
    Write-Type "AUTHORIZED USER: $env:USERNAME" 10
    Write-Type "SYSTEM NODE: $env:COMPUTERNAME" 10
    Write-Type "STATUS: ONLINE" 10
    Write-Host ""
}

# ============================================================
#  Starship Prompt
# ============================================================

Invoke-Expression (&starship init powershell --print-full-init | Out-String)

# ============================================================
#  PSReadLine (History / UX)
# ============================================================

Import-Module PSReadLine

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView
Set-PSReadLineOption -BellStyle None

# ============================================================
#  Aliases & Tools
# ============================================================

function lsx { eza -1l --icons always --group-directories-first }
function lsa { eza -1l --icons always --group-directories-first -a }

function top {
    Get-Process | Sort-Object CPU -Descending |
    Select-Object -First 15 |
    Format-Table -Auto
}

function glog {
    git log --graph --oneline --decorate --all
}
Set-Alias gg glog

Set-Alias ls lsx
Set-Alias cat Get-Content
Set-Alias nslookup Resolve-DnsName

# ============================================================
#  Optional toggles (manuell)
# ============================================================

# CRT AUS:
#   $env:CRT="0"; . $PROFILE
#
# CRT AN:
#   Remove-Item Env:\CRT; . $PROFILE
#
# Intro erneut anzeigen:
#   Remove-Item Env:\ROBCO_SHOWN; . $PROFILE
#
# ============================================================
function Set-RobCoWindowTitle {
    $path = (Get-Location).Path
    $host.UI.RawUI.WindowTitle = "ROBCO INDUSTRIES (TM) — TERMLINK — NODE $env:COMPUTERNAME"
}

# Beim Start
Set-RobCoWindowTitle

# Nach jedem Befehl aktualisieren
Register-EngineEvent PowerShell.OnIdle -Action {
    Set-RobCoWindowTitle
} | Out-Null
