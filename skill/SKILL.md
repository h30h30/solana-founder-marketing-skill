---
name: solana-founder-marketing
description: >
  Go-to-market intelligence for Solana founders. Use this skill when
  the user asks about market trends, competitor analysis, launch planning,
  tokenomics audit, GitHub analysis, or on-chain activity on Solana.
---

# Solana Founder Marketing Skill

Go-to-market intelligence for Solana founders. Every recommendation
is grounded in live data — not generic marketing content.

---

## GLOBAL RULES — Apply Before Everything Else

Rule 0: If the user's message contains a github.com URL, do NOT use
WebFetch on that URL. GitHub pages are HTML — not useful data.
Always use GitHub REST API instead:
- github.com/owner/repo → api.github.com/repos/owner/repo
- github.com/org → api.github.com/orgs/org/repos
Load github-intelligence.md for the correct API commands.

### Market data (trending tokens + Solana protocols)

Run the fetch script directly — do not ask the user to run it manually:

```bash
# Mac/Linux
bash fetch-trending.sh

# Windows
powershell -ExecutionPolicy Bypass -File fetch-trending.ps1
```

Then use the output for analysis. Do not fetch raw API URLs directly —
the script pre-filters and formats the data efficiently.

### GitHub analysis

Use GitHub REST API directly. Never use WebFetch on github.com.
Always require a GitHub URL or org/repo path before starting.

```bash
curl -s -H "User-Agent: solana-founder-marketing-skill" \
  "https://api.github.com/repos/{owner}/{repo}/stats/commit_activity"
```

### On-chain analysis

Requires a Helius API key and program ID from the user.
Ask for both before proceeding.

---

## Scope — What This Skill Does NOT Cover

- Idea validation → use idea-sprint/ wrapper
- Pitch deck creation → use pitch-deck/ wrapper
- Hackathon submissions → use hackathon/ wrapper
- Startup research → use ext/colosseum/

---

## Commands

| Command | What It Does |
|---------|-------------|
| `/analyze-market` | Runs fetch script + identifies underserved niches |
| `/audit-project` | Full GTM audit in one guided session |

## Agent

```
Use gtm-advisor to analyze our market position
Use gtm-advisor to audit our tokenomics
```

---

## Skill Routing

| The founder asks about...                         | Load this file           |
|---------------------------------------------------|--------------------------|
| Trending tokens or protocols on Solana            | `market-intelligence.md` |
| Comparing TVL/volume/fees to competitors          | `competitive-analysis.md`|
| Any GitHub repo — activity, health, what to learn | `github-intelligence.md` |
| On-chain wallet/transaction activity              | `onchain-pulse.md`       |
| What to do before/after mainnet launch            | `gtm-checklist.md`       |
| Which metrics signal real traction                | `metrics-that-matter.md` |
| Token distribution, vesting, utility              | `tokenomics-audit.md`    |

---

## Core Constraint

Never produce generic advice. Every recommendation must cite either:
1. A live data point fetched from the APIs above, OR
2. A specific, named ecosystem example (e.g. "Jupiter allocated 50% to community")

If data is unavailable, fetch it — don't ask the user to fetch it for you.
