# Competitive Analysis on Solana

## CRITICAL RULES — READ FIRST

Rule 1: If the user's message contains live market data (lines with "===", 
"---", or "Vol:", "Fees:", "Rank:"), that IS the competitive data.
Use it directly. Do NOT fetch any URLs. Do NOT search Google.

Rule 2: If no data is in the message, ask the user to run 
fetch-trending.ps1 and paste the output before continuing.

Rule 3: Never fetch raw API URLs — responses are too large to process efficiently.

---

## How to Interpret the Pasted Data

### Volume vs Fees Signal

| Pattern                        | What It Means                                    |
|--------------------------------|--------------------------------------------------|
| High vol, zero fees            | No fee capture — protocol not monetizing         |
| High fees relative to vol      | Strong fee model — PumpSwap is the benchmark     |
| Vol > $100M, no fees listed    | Either free protocol or fees not tracked         |
| Multiple protocols same category | Saturated — need niche differentiation         |

### Competitive Positioning Matrix

| Their Strength     | Your Counter-Move                             |
|--------------------|-----------------------------------------------|
| High TVL           | Target a token niche they ignore              |
| Strong brand       | Emphasize trustlessness / no team risk        |
| VC-backed          | Community-owned angle, fairer launch          |
| Multichain         | "Built for Solana" — raw performance story    |
| Older codebase     | Token-2022 extensions they have not adopted   |
| General purpose    | Specialize in one underserved category        |

### Category Saturation Check

Count how many protocols in the pasted data share the same category tag:
- 8+ same category → extremely saturated, avoid direct competition
- 5–7 same category → competitive, strong differentiation needed
- 1–3 same category → opportunity, but validate demand first
- 0 in category → either untapped gap or no demand yet

---

## Response Format

When analyzing competitive landscape from pasted data:

```
COMPETITIVE SUMMARY ([date from data]):
Top protocols by volume: [list top 3 with numbers]
Top protocols by fees: [list top 3 with numbers]
Category breakdown: [X DEXes, Y Lending, Z Other]

SATURATION LEVEL: [High / Medium / Low]
[One sentence explaining why]

YOUR DEFENSIBLE EDGE:
[One thing the user's protocol can claim that none of the listed protocols can]

RECOMMENDED ONE-LINER:
"[Specific, differentiated, no buzzwords]"

RED FLAGS TO AVOID:
[Any positioning traps based on the data]
```

Always close with: "Here is the one thing you can claim that they cannot."
