---
name: audit-project
description: Runs a full go-to-market audit on a Solana project covering positioning, tokenomics, fundraising readiness, and GitHub activity in one guided session.
---

# Command: /audit-project

Runs a full go-to-market audit on a Solana project in one session.
Covers positioning, tokenomics, fundraising readiness, and GitHub activity.

## Usage

```
/audit-project
```

## What This Command Does

Guides the founder through a structured audit by asking for information
in sequence, then running all relevant skill files.

## Instructions for Claude

When this command is invoked, collect information step by step:

### Step 1 — Ask for project basics
"To run a full GTM audit, I need some details about your project.
Let's go through this step by step.

First: What is your project?
- Name
- One sentence description
- Category (DEX / Lending / Liquid Staking / Perps / Other)
- Current stage (idea / devnet / mainnet)"

### Step 2 — Positioning (load positioning-audit.md)
Ask: "What is your current tagline or one-liner?"
Run positioning audit on their answer.

### Step 3 — Tokenomics (load tokenomics-audit.md)
Ask: "Share your token distribution if you have one:
- Total supply
- Team %
- Investors %
- Community %
- Treasury %
- Vesting schedule"

If they say "not defined yet" — note it as a red flag and move on.

### Step 4 — Fundraising (load fundraising-readiness.md)
Ask: "A few quick questions for fundraising readiness:
- Are you live on mainnet? If yes, how long?
- How many unique wallets do you have?
- Do you have any protocol revenue?
- How many full-time team members?"

### Step 5 — GitHub (load github-intelligence.md)
Ask: "Do you have a public GitHub repo?
If yes, share the URL. If no, I will give setup recommendations."

### Step 6 — Full Report
Compile all findings into one report:

```
FULL GTM AUDIT — [Project Name]
Date: [today]

PROJECT: [name] | [category] | [stage]

POSITIONING: [Pass / Warning / Fail]
[Key finding in one sentence]

TOKENOMICS: [Pass / Warning / Fail]
[Key finding in one sentence]

FUNDRAISING READINESS: [Score/100] — [Verdict]
[Key finding in one sentence]

GITHUB: [Active / Slow / Not started]
[Key finding in one sentence]

OVERALL SCORE: [X/4 sections passing]

TOP 3 PRIORITIES RIGHT NOW:
1. [Most critical action]
2. [Second action]
3. [Third action]

ESTIMATED TIME TO RAISE-READY: [X weeks/months]
```
