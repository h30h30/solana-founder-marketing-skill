# Market Intelligence — Trending Tokens & Solana Protocol Activity

Live market signals using two free APIs. No API key required.

---

## CRITICAL RULES

Rule 1: Always run the fetch script to get live data. Do not ask the
user to run it — execute it directly.

Rule 2: Never fetch raw API URLs directly — responses are too large.
The fetch script pre-filters to top 10 items.

Rule 3: Never use Google Search for market data.

---

## How to Fetch Data

### Claude Code / bash environments:
```bash
bash fetch-trending.sh
```

### Windows / PowerShell environments:
```powershell
powershell -ExecutionPolicy Bypass -File fetch-trending.ps1
```

The script outputs:
- Top 10 trending tokens from CoinGecko (price, MCap rank, 24h change)
- Top 10 Solana protocols by TVL across all categories (DeFiLlama)
- Top 10 Solana protocols by 24h fees + revenue (DeFiLlama)

---

## How to Interpret the Output

### Trending Token Signals

| Signal | What It Means |
|--------|--------------|
| Unranked token trending | New/small cap with sudden momentum |
| Mid-cap (#50–#500) trending | Sweet spot — real demand, not yet overcrowded |
| 24h change > +20% | Strong momentum — investigate the catalyst |
| 24h change negative but trending | Accumulation — buyers despite price drop |

### Protocol TVL Signals

| Signal | What It Means |
|--------|--------------|
| Category dominates top 10 | Saturated — avoid direct competition |
| Category absent from top 10 | Potential gap — validate demand |
| TVL declining 7d | Protocol losing confidence |
| TVL growing while market flat | Strong product-market fit |

### Fee Revenue Signals

| Signal | What It Means |
|--------|--------------|
| High fees, low TVL | Capital-efficient — users pay for value |
| High TVL, near-zero fees | Not monetizing — mercenary liquidity |
| Fees > $1M/24h | Protocol with real economic activity |

---

## How to Find Underserved Niches

After fetching data, answer three questions:

**1. What token categories are trending?**
Group tokens by type: memecoin / DeFi / privacy-ZK / gaming-NFT / infra / other

**2. Which categories are absent from top protocols by TVL and fees?**
A category trending in tokens but absent from top protocols = gap.

**3. What would a protocol built specifically for that category look like?**

---

## Response Format

```
MARKET INTELLIGENCE REPORT
Date: [today — fetched live]

TRENDING TOKENS SUMMARY:
[Top 3 most interesting with price and 24h change]

TOP PROTOCOLS BY TVL:
[Top 3 with category and TVL]

TOP PROTOCOLS BY FEES:
[Top 3 with 24h fees and revenue if available]

CATEGORY BREAKDOWN:
[X] tokens in [category A]
[Y] protocols in [category A]
Gap: [yes/no — explain]

GAP IDENTIFIED:
[Specific niche with evidence from the data]

POSITIONING ANGLE:
"[One sentence a new protocol could own]"

CONFIDENCE: [High / Medium / Low]
REASON: [Why this gap is real, not just an absence in the data]
```

---

## Bash Version for fetch-trending.sh (Mac/Linux)

If `fetch-trending.ps1` is not available, use this bash equivalent:

```bash
#!/bin/bash
LIMIT=10
echo "=== LIVE MARKET DATA ==="
echo "Fetched: $(date -u '+%Y-%m-%d %H:%M') UTC"
echo ""

echo "--- TOP $LIMIT TRENDING TOKENS (CoinGecko) ---"
curl -s "https://api.coingecko.com/api/v3/search/trending" | python3 -c "
import json, sys
data = json.load(sys.stdin)
for c in data['coins'][:$LIMIT]:
    item = c['item']
    rank = item.get('market_cap_rank', 'unranked')
    chg = item.get('data',{}).get('price_change_percentage_24h',{}).get('usd','N/A')
    chg = round(chg,1) if isinstance(chg,float) else chg
    price = item.get('data',{}).get('price', 'N/A')
    price = round(float(price),4) if price != 'N/A' else 'N/A'
    print(f\"  {item['name']} ({item['symbol']}) | Price: USD {price} | MCap Rank: No.{rank} | 24h: {chg}%\")
"

echo ""
echo "--- TOP $LIMIT SOLANA PROTOCOLS BY TVL (DeFiLlama) ---"
curl -s "https://api.llama.fi/protocols" | python3 -c "
import json, sys
data = json.load(sys.stdin)
results = []
for p in data:
    tvls = p.get('chainTvls', {})
    sol_tvl = tvls.get('Solana', 0)
    if sol_tvl > 1000000 and p.get('category') not in ['CEX','Chain']:
        results.append((p['name'], p.get('category','Protocol'), sol_tvl, p.get('change_1d',0), p.get('change_7d',0)))
results.sort(key=lambda x: x[2], reverse=True)
for name,cat,tvl,d1,d7 in results[:$LIMIT]:
    print(f\"  [{cat}] {name} | TVL: USD {round(tvl/1e6,1)}M | 1d: {round(d1,1)}% | 7d: {round(d7,1)}%\")
"

echo ""
echo "--- TOP $LIMIT SOLANA PROTOCOLS BY 24H FEES (DeFiLlama) ---"
curl -s "https://api.llama.fi/overview/fees/Solana?excludeTotalDataChart=true" | python3 -c "
import json, sys
data = json.load(sys.stdin)
protocols = sorted(data.get('protocols',[]), key=lambda x: x.get('total24h',0) or 0, reverse=True)
for p in protocols[:$LIMIT]:
    fees = round((p.get('total24h') or 0)/1000, 1)
    rev = round((p.get('revenue24h') or 0)/1000, 1)
    rev_str = f' | Revenue: USD {rev}K' if rev > 0 else ''
    chg = round(p.get('change_1d',0) or 0, 1)
    print(f\"  {p['name']} | Fees: USD {fees}K | 1d: {chg}%{rev_str}\")
"

echo ""
echo "=== END ==="
```
