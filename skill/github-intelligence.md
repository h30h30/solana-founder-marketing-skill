---
name: github-intelligence
description: Analyzes any Solana project's GitHub activity and gives actionable insights for builders who want to learn from it or build something similar.
---

# GitHub Intelligence

Analyzes any Solana project's GitHub repository — competitor, reference project,
or inspiration — and extracts actionable insights for builders.

---

## CRITICAL RULES

Rule 1: NEVER use WebFetch or browse github.com — it is slow and unreliable.
Rule 2: ALWAYS use GitHub REST API endpoints directly.
Rule 3: A GitHub URL or org/repo path is REQUIRED before starting.
        If not provided, ask for it immediately. Do not search Google.
Rule 4: Never guess or estimate numbers. If API returns no data, say so.

Correct API base: https://api.github.com/repos/{owner}/{repo}/
NOT: https://github.com/{owner}/{repo}

---

## Methodology

When analyzing a GitHub org or repo, this skill follows this approach:

1. **Fetch all repos** sorted by most recently pushed
2. **Separate forks from original repos** — forks are excluded from deep analysis
   but their count is noted as a signal
3. **Select the most recently pushed non-fork repo** for commit/contributor analysis
4. **Never select by stars** — a recently active low-star repo is more relevant
   than a stale high-star one
5. **Count total forks across the org** as a community adoption signal

### Fork Count Signal

Forks across an org show how many builders found the code useful enough to copy.

| Total org forks | Signal |
|-----------------|--------|
| > 500 | High ecosystem adoption — widely referenced |
| 100–500 | Solid traction — growing developer interest |
| 20–100 | Early adopters — niche but real interest |
| < 20 | Early stage or private-focused project |

To count total forks across all repos:
```powershell
$totalForks = ($repos | ForEach-Object { $_.forks_count } | Measure-Object -Sum).Sum
Write-Host "Total forks across org: $totalForks"
```

This number goes in the report as context — not analyzed further.

Before doing anything, check if the user provided a GitHub URL or org/repo path.

If YES and URL points to a specific repo (e.g. github.com/onre-finance/onre-sol):
→ extract owner and repo, proceed to Step 1.

If YES and URL points to an org only (e.g. github.com/LoopscaleLabs):
→ first fetch all repos in the org, find the most recently pushed non-fork,
  then proceed to Step 1 with that repo.

If NO — ask:
"Please share the GitHub URL or org/repo path for the project you want to analyze.
Example: https://github.com/MeteoraAg or https://github.com/MeteoraAg/dlmm-sdk"

Do not proceed until a URL or path is provided.

### When URL is an org — find the right repo first

```powershell
$org = "LoopscaleLabs"  # replace with org name
$headers = @{ "User-Agent" = "solana-founder-marketing-skill" }

$repos = Invoke-RestMethod -Uri "https://api.github.com/orgs/$org/repos?sort=pushed&direction=desc&per_page=30" -Headers $headers

# Separate own repos from forks
$ownRepos = $repos | Where-Object { $_.fork -eq $false }
$forks    = $repos | Where-Object { $_.fork -eq $true }

Write-Host "Own repos (most recently pushed first):"
$ownRepos | Select-Object -First 5 | ForEach-Object {
    Write-Host "  $($_.name) | Stars: $($_.stargazers_count) | Last push: $($_.pushed_at)"
}
Write-Host ""
Write-Host "Recent forks (reference only):"
$forks | Select-Object -First 3 | ForEach-Object {
    Write-Host "  $($_.name) | Last push: $($_.pushed_at) [FORK]"
}
```

Always pick the most recently pushed **non-fork** repo for deep analysis.
Never pick by stars — a stale starred repo is less relevant than a
recent low-star repo. If all non-fork repos are stale, note it explicitly.

---

## Step 1: Fetch Repository Data

```powershell
$owner = "onre-finance"   # replace
$repo  = "onre-sol"       # replace
$headers = @{ "User-Agent" = "solana-founder-marketing-skill" }

# Basic repo info
$repoData = Invoke-RestMethod -Uri "https://api.github.com/repos/$owner/$repo" -Headers $headers
Write-Host "Stars:        $($repoData.stargazers_count)"
Write-Host "Forks:        $($repoData.forks_count)"
Write-Host "Open issues:  $($repoData.open_issues_count)"
Write-Host "Language:     $($repoData.language)"
Write-Host "Last push:    $($repoData.pushed_at)"
Write-Host "Created:      $($repoData.created_at)"
Write-Host "Description:  $($repoData.description)"
```

---

## Step 2: Fetch Commit Activity

```powershell
$commits = Invoke-RestMethod -Uri "https://api.github.com/repos/$owner/$repo/stats/commit_activity" -Headers $headers

if ($commits -is [array] -and $commits.Count -gt 0) {
    $last4  = ($commits | Select-Object -Last 4  | ForEach-Object { $_.total } | Measure-Object -Sum).Sum
    $last12 = ($commits | Select-Object -Last 12 | ForEach-Object { $_.total } | Measure-Object -Sum).Sum
    $last52 = ($commits | ForEach-Object { $_.total } | Measure-Object -Sum).Sum
    Write-Host "Commits last 4w:  $last4"
    Write-Host "Commits last 12w: $last12"
    Write-Host "Commits last 52w: $last52"
} else {
    Write-Host "Stats not ready (202). Wait 30 seconds and retry."
}
```

---

## Step 3: Fetch Contributors

```powershell
$contributors = Invoke-RestMethod -Uri "https://api.github.com/repos/$owner/$repo/contributors" -Headers $headers
$human = $contributors | Where-Object { $_.type -eq "User" }
Write-Host "Human contributors: $($human.Count)"
if ($human.Count -gt 0) {
    Write-Host "Top contributor: $($human[0].login) — $($human[0].contributions) commits"
}
```

---

## How to Interpret Results

### Activity Level

| Commits (last 4w) | Status |
|-------------------|--------|
| > 30 | Very active |
| 15–30 | Active |
| 5–14 | Maintenance mode |
| 1–4 | Near-stale |
| 0 | Inactive |

### Team Size Signal

| Human contributors | Signal |
|--------------------|--------|
| > 10 | Open source community or large team |
| 5–10 | Healthy small team |
| 2–4 | Core team — key person risk |
| 1 | Solo — high bus factor risk |

### Repo Age vs Activity

| Repo age | Commits/year | Assessment |
|----------|-------------|------------|
| < 6mo | Any | Early stage — normal variance |
| 6–18mo | > 100 | Actively building |
| 6–18mo | < 50 | Slowing down |
| > 18mo | < 30 | Maintenance or abandoned |

---

## What to Learn From This Repo

After fetching data, always answer these three questions:

**1. What is this project doing well?**
Look at: consistent commit history, contributor growth, issue response time,
clear README, TypeScript/Rust split, test coverage signals.

**2. What are the gaps or risks?**
Look at: single contributor, no recent commits, many open issues with no response,
no tests, unclear architecture in description.

**3. If you wanted to build something similar, what would you do differently?**

Use this framework:

```
WHAT TO KEEP:
- [Architecture or pattern worth replicating]
- [Community approach worth following]

WHAT TO IMPROVE:
- [Gap in their repo you could fill]
- [Risk in their setup you would avoid]

WHAT TO SKIP:
- [Something they did that added complexity without value]
```

---

## Response Format

```
GITHUB ANALYSIS — [Project Name]
Date: [today]
Org: [URL] | Repo analyzed: [owner/repo]

METHODOLOGY:
Repos in org: [X total] ([Y own] + [Z forks — not analyzed])
Selected: [repo name] — most recently pushed non-fork repo
Total org forks: [X] — [High / Solid / Early / Low] community adoption

REPO OVERVIEW:
Language: [main language]
Created: [date] | Last push: [date]
Stars: [X] | Forks: [X] | Open issues: [X]

ACTIVITY:
Commits (4w / 12w / 52w): [X] / [X] / [X]
Human contributors: [X]
Top contributor: [login] ([X] commits)
Status: [Very Active / Active / Maintenance / Stale / Inactive]

KEY OBSERVATIONS:
1. [Most notable positive signal]
2. [Most notable risk or gap]
3. [Architecture or approach worth noting]

IF YOU WANT TO BUILD SOMETHING SIMILAR:

KEEP:
- [What worked well here]

IMPROVE:
- [Gap you could fill]

AVOID:
- [Risk or complexity not worth replicating]
```
