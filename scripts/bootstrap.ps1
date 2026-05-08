#
# Bootstrap script for github-patterns marketplace assets.
#
# USAGE:
#   .\bootstrap.ps1 -Stack laravel -Phases @("A", "B", "C")
#   .\bootstrap.ps1 -Stack nodejs -Phases @("A", "B", "C", "D", "E") -Visibility private
#

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("nodejs", "python", "laravel", "vuejs")]
    [string]$Stack,

    [Parameter(Mandatory=$true)]
    [string[]]$Phases,

    [ValidateSet("public", "private")]
    [string]$Visibility = "public",

    [string]$RegistryUrl = "https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/registry.json",

    [string]$OutputPath = "."
)

$PhaseOrder = @("A", "B", "C", "D", "E")
$MaxRetries = 3
$RetryDelayMs = 2000
$LogFile = Join-Path $OutputPath "bootstrap.log"
$FailedAssets = @()
$StartTime = Get-Date

function Write-Log {
    param([string]$Msg, [string]$Lvl = "INFO")
    $ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "[{0}] [{1}] {2}" -f $ts, $Lvl, $Msg
    Write-Host $line
    Add-Content -Path $LogFile -Value $line -ErrorAction SilentlyContinue
}

function Get-Version {
    return "1.0.0"
}

function Test-PhaseSeq {
    param([string[]]$PList)
    $idx = @()
    
    foreach ($p in $PList) {
        if ($p -notin $PhaseOrder) {
            Write-Log "Invalid phase: $p" "ERROR"
            return $false
        }
        $idx += $PhaseOrder.IndexOf($p)
    }
    
    $srt = $idx | Sort-Object
    for ($i = 0; $i -lt $srt.Count - 1; $i++) {
        if ($srt[$i+1] - $srt[$i] -ne 1) {
            Write-Log "Phase gap in: $($PList -join ',')" "ERROR"
            return $false
        }
    }
    return $true
}

function Test-OutputWritable {
    param([string]$Path)
    
    if (-not (Test-Path $Path)) {
        try {
            New-Item -ItemType Directory -Path $Path -Force | Out-Null
        } catch {
            Write-Log "Cannot create: $Path" "ERROR"
            return $false
        }
    }
    
    $tf = Join-Path $Path ".test"
    try {
        "x" | Out-File -FilePath $tf -Force -ErrorAction Stop
        Remove-Item $tf -Force -ErrorAction SilentlyContinue
        return $true
    } catch {
        Write-Log "No write permission: $Path" "ERROR"
        return $false
    }
}

function Get-WebContent {
    param([string]$Uri, [string]$Out = $null, [int]$Try = 1)
    
    try {
        if ($Out) {
            Invoke-WebRequest -Uri $Uri -OutFile $Out -TimeoutSec 30 -ErrorAction Stop | Out-Null
            return $true
        } else {
            $r = Invoke-WebRequest -Uri $Uri -TimeoutSec 30 -ErrorAction Stop
            return $r.Content
        }
    } catch {
        if ($Try -le $MaxRetries) {
            $delay = $RetryDelayMs * [Math]::Pow(2, $Try-1)
            Write-Log "Retry $Try/$MaxRetries (delay: ${delay}ms)" "WARN"
            Start-Sleep -Milliseconds $delay
            return Get-WebContent -Uri $Uri -Out $Out -Try ($Try+1)
        }
        Write-Log "Failed: $Uri" "ERROR"
        return $false
    }
}

function Create-DirIfMissing {
    param([string]$Path)
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Log "Created: $Path"
    }
}

function File-HasContent {
    param([string]$File)
    return (Test-Path $File) -and ((Get-Item $File).Length -gt 0)
}

function Backup-OldFile {
    param([string]$File)
    if (Test-Path $File) {
        $ts = Get-Date -Format "yyyyMMdd-HHmmss"
        $bak = "$File.backup.$ts"
        Copy-Item -Path $File -Destination $bak -Force
        Write-Log "Backed up: $bak"
    }
}

function Main {
    Write-Log "Bootstrap v$(Get-Version) - Stack: $Stack, Phases: $($Phases -join ','), Vis: $Visibility"
    
    if (-not (Test-PhaseSeq -PList $Phases)) {
        exit 1
    }
    
    if (-not (Test-OutputWritable -Path $OutputPath)) {
        exit 1
    }
    
    Write-Log "Downloading registry..."
    $json = Get-WebContent -Uri $RegistryUrl
    if (-not $json) {
        Write-Log "Registry download failed" "ERROR"
        exit 1
    }
    
    try {
        $reg = $json | ConvertFrom-Json -ErrorAction Stop
    } catch {
        Write-Log "JSON parse failed" "ERROR"
        exit 1
    }
    
    $assets = @{}
    foreach ($ph in $Phases) {
        foreach ($aid in $reg.core.github_100_percent.phases.$ph.assets) {
            $assets[$aid] = $true
        }
    }
    
    foreach ($aid in $reg.stacks.$Stack.recommended_assets) {
        $assets[$aid] = $true
    }
    
    Write-Log "Assets to fetch: $($assets.Count)"
    
    Create-DirIfMissing (Join-Path $OutputPath ".github")
    Create-DirIfMissing (Join-Path $OutputPath ".github/agents")
    Create-DirIfMissing (Join-Path $OutputPath ".github/workflows")
    Create-DirIfMissing (Join-Path $OutputPath "docs/standards")
    
    $ok = 0
    $bad = 0
    
    foreach ($aid in $assets.Keys) {
        $a = $null
        foreach ($cat in @("agents", "instructions", "workflows", "standards", "intelligence")) {
            if ($reg.assets.$cat.PSObject.Properties.Name -contains $aid) {
                $a = $reg.assets.$cat.$aid
                break
            }
        }
        
        if (-not $a) {
            Write-Log "Not found: $aid" "WARN"
            $bad++
            $FailedAssets += $aid
            continue
        }
        
        $src = "{0}{1}" -f $reg.endpoint_base, $a.path
        $tgt = if ($a.target) { $a.target } else { $a.path }
        $full = Join-Path $OutputPath $tgt
        $dir = Split-Path $full
        
        Create-DirIfMissing $dir
        
        if (File-HasContent $full) {
            Write-Log "Exists (skip): $aid"
            $ok++
        } else {
            if (Get-WebContent -Uri $src -Out $full) {
                if (File-HasContent $full) {
                    Write-Log "Downloaded: $aid"
                    $ok++
                } else {
                    Write-Log "Empty: $aid" "ERROR"
                    $bad++
                    $FailedAssets += $aid
                }
            } else {
                Write-Log "Failed: $aid" "WARN"
                $bad++
                $FailedAssets += $aid
            }
        }
    }
    
    $llms = Join-Path $OutputPath "llms.txt"
    Backup-OldFile $llms
    
    $content = "# LLM Intelligence Index`r`nStack: $Stack`r`nPhases: $($Phases -join ',')`r`n`r`n## Agents`r`n"
    Get-ChildItem (Join-Path $OutputPath ".github/agents") -Filter "*.agent.md" -ErrorAction SilentlyContinue | ForEach-Object {
        $content += "- {0}`r`n" -f $_.Name
    }
    
    $content += "`r`n## Standards`r`n"
    Get-ChildItem (Join-Path $OutputPath "docs/standards") -Filter "*.md" -ErrorAction SilentlyContinue | ForEach-Object {
        $content += "- {0}`r`n" -f $_.Name
    }
    
    $content | Out-File -FilePath $llms -Encoding UTF8
    Write-Log "Generated: $llms"
    
    $total = $ok + $bad
    $pct = if ($total -gt 0) { [Math]::Floor(($ok / $total) * 100) } else { 0 }
    $dur = [int]((Get-Date) - $StartTime).TotalSeconds
    
    Write-Log ""
    Write-Log "========== COMPLETE =========="
    Write-Log "Downloaded: $ok/$total assets ($pct percent)"
    
    if ($FailedAssets.Count -gt 0) {
        Write-Log "Failed: $($FailedAssets -join ', ')" "ERROR"
    }
    
    Write-Log "Duration: ${dur}s"
    Write-Log "Log: $LogFile"
    Write-Log "==============================="
    
    $thresh = [Math]::Ceiling($assets.Count * 0.20)
    if ($bad -gt $thresh) {
        Write-Log "Too many failures: $bad > $thresh" "ERROR"
        exit 1
    }
    
    exit 0
}

Main
