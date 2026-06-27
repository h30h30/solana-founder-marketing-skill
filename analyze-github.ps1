# analyze-github.ps1
# GitHub Intelligence Script for solana-founder-marketing-skill
# Run this script and paste the output into your AI session
#
# Usage:
#   Org:  powershell -ExecutionPolicy Bypass -File analyze-github.ps1 -Owner LoopscaleLabs
#   Repo: powershell -ExecutionPolicy Bypass -File analyze-github.ps1 -Owner MeteoraAg -Repo dlmm-sdk

param(
    [Parameter(Mandatory=$true)]  [string]$Owner,
    [Parameter(Mandatory=$false)] [string]$Repo,
    [Parameter(Mandatory=$false)] [string]$ApiToken = $env:GITHUB_TOKEN
)

$headers = @{ "User-Agent" = "solana-founder-marketing-skill" }
if ($ApiToken) { $headers["Authorization"] = "token $ApiToken" }

Write-Host "=== GITHUB INTELLIGENCE ===" -ForegroundColor Cyan
Write-Host "Fetched: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
Write-Host ""

# If only org provided, find best repo
if (-not $Repo) {
    Write-Host "Fetching repos for org: $Owner..." -ForegroundColor Yellow
    try {
        $repos = Invoke-RestMethod -Uri "https://api.github.com/orgs/$Owner/repos?sort=pushed&direction=desc&per_page=30" -Headers $headers
        $ownRepos = $repos | Where-Object { $_.fork -eq $false }
        $forks    = $repos | Where-Object { $_.fork -eq $true }
        $totalForks = ($repos | ForEach-Object { $_.forks_count } | Measure-Object -Sum).Sum

        Write-Host "Repos in org: $($repos.Count) total ($($ownRepos.Count) own + $($forks.Count) forks)"
        Write-Host "Total forks across org: $totalForks"
        Write-Host ""
        Write-Host "Own repos (most recently pushed):"
        $ownRepos | Select-Object -First 5 | ForEach-Object {
            Write-Host "  $($_.name) | Stars: $($_.stargazers_count) | Last push: $($_.pushed_at)"
        }
        Write-Host ""

        $selected = $ownRepos | Select-Object -First 1
        if (-not $selected) {
            Write-Host "No non-fork repos found." -ForegroundColor Red
            exit 1
        }
        $Repo = $selected.name
        Write-Host "Selected for analysis: $Repo (most recently pushed non-fork)" -ForegroundColor Green
        Write-Host ""
    } catch {
        Write-Host "ERROR fetching org repos: $_" -ForegroundColor Red
        exit 1
    }
}

# Analyze the repo
Write-Host "--- REPO: $Owner/$Repo ---"
try {
    $r = Invoke-RestMethod -Uri "https://api.github.com/repos/$Owner/$Repo" -Headers $headers
    Write-Host "Language:    $($r.language)"
    Write-Host "Created:     $($r.created_at)"
    Write-Host "Last push:   $($r.pushed_at)"
    Write-Host "Stars:       $($r.stargazers_count)"
    Write-Host "Forks:       $($r.forks_count)"
    Write-Host "Open issues: $($r.open_issues_count)"
    Write-Host "Description: $($r.description)"
} catch {
    Write-Host "ERROR fetching repo: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "--- COMMIT ACTIVITY ---"
try {
    $commits = Invoke-RestMethod -Uri "https://api.github.com/repos/$Owner/$Repo/stats/commit_activity" -Headers $headers
    if ($commits -is [array] -and $commits.Count -gt 0) {
        $w4  = ($commits | Select-Object -Last 4  | ForEach-Object { $_.total } | Measure-Object -Sum).Sum
        $w12 = ($commits | Select-Object -Last 12 | ForEach-Object { $_.total } | Measure-Object -Sum).Sum
        $w52 = ($commits | ForEach-Object { $_.total } | Measure-Object -Sum).Sum
        Write-Host "Commits last 4w:  $w4"
        Write-Host "Commits last 12w: $w12"
        Write-Host "Commits last 52w: $w52"
        $status = if ($w4 -gt 30) { "Very Active" } elseif ($w4 -gt 15) { "Active" } elseif ($w4 -gt 5) { "Maintenance" } elseif ($w4 -gt 0) { "Near-stale" } else { "Inactive" }
        Write-Host "Status: $status"
    } else {
        Write-Host "Stats computing (202). Wait 30s and retry."
    }
} catch {
    Write-Host "ERROR fetching commits: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "--- CONTRIBUTORS ---"
try {
    $contributors = Invoke-RestMethod -Uri "https://api.github.com/repos/$Owner/$Repo/contributors" -Headers $headers
    $human = $contributors | Where-Object { $_.type -eq "User" }
    Write-Host "Human contributors: $($human.Count)"
    if ($human.Count -gt 0) {
        Write-Host "Top: $($human[0].login) ($($human[0].contributions) commits)"
    }
} catch {
    Write-Host "ERROR fetching contributors: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== END ==="
Write-Host "Paste the output above into your AI session for analysis." -ForegroundColor Cyan
