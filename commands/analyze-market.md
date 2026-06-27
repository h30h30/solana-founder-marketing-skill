---
name: analyze-market
description: Fetches live Solana market data and identifies underserved niches for a new protocol. Requires pasted output from fetch-trending.ps1.
---

# Command: /analyze-market

Fetches live market data and identifies underserved niches for a new Solana protocol.

## Usage

```
/analyze-market
```

## What This Command Does

1. Reminds the user to run fetch-trending.ps1 if not already done
2. Loads market-intelligence.md
3. Analyzes trending tokens vs active protocols
4. Outputs a structured market opportunity report

## Instructions for Claude

When this command is invoked:

1. Check if the user's message contains live market data
   (lines with "===", "Vol:", "TVL:", "MCap Rank:")

2. If YES — proceed directly to analysis using market-intelligence.md

3. If NO — respond with:
   "To run /analyze-market, first fetch live data:
   
   **Windows:**
   powershell -ExecutionPolicy Bypass -File fetch-trending.ps1
   
   **Mac/Linux:**
   bash fetch-trending.sh
   
   Then paste the output here and I will analyze it."

4. Output format — always use this structure:

```
MARKET OPPORTUNITY REPORT
Date: [today]

TRENDING TOKENS SUMMARY:
[Top 3 most interesting tokens with 24h change]

TOP PROTOCOLS BY TVL:
[Top 3 with category]

TOP PROTOCOLS BY FEES:
[Top 3 with fees/revenue]

GAP IDENTIFIED:
[Specific niche present in trending but absent from top protocols]

POSITIONING ANGLE:
"[One sentence a new protocol could own]"

CONFIDENCE: [High / Medium / Low]
REASON: [Why this gap is real, not just an absence]
```
