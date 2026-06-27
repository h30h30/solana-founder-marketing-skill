#!/bin/bash
# fetch-trending.sh
# Mac/Linux version of fetch-trending.ps1
LIMIT=${1:-10}

echo "=== LIVE MARKET DATA ==="
echo "Fetched: $(date -u '+%Y-%m-%d %H:%M') UTC"
echo ""

# 1. CoinGecko trending tokens
echo "--- TOP $LIMIT TRENDING TOKENS (most searched on CoinGecko) ---"
curl -s "https://api.coingecko.com/api/v3/search/trending" | python3 -c "
import json, sys
data = json.load(sys.stdin)
limit = $LIMIT
for c in data['coins'][:limit]:
    item = c['item']
    rank = item.get('market_cap_rank', 'unranked')
    chg = item.get('data',{}).get('price_change_percentage_24h',{}).get('usd','N/A')
    chg = str(round(chg,1))+'%' if isinstance(chg,float) else 'N/A'
    price_raw = item.get('data',{}).get('price', None)
    if price_raw:
        p = float(price_raw)
        if p >= 1: price = 'USD '+str(round(p,2))
        elif p >= 0.01: price = 'USD '+str(round(p,4))
        else: price = 'USD '+str(round(p,6))
    else:
        price = 'N/A'
    print(f\"  {item['name']} ({item['symbol']}) | Price: {price} | MCap Rank: No.{rank} | 24h: {chg}\")
" 2>/dev/null || echo "  ERROR fetching tokens"

echo ""

# 2. Solana protocols by TVL — all categories
echo "--- TOP $LIMIT SOLANA PROTOCOLS BY TVL (DeFiLlama) ---"
curl -s "https://api.llama.fi/protocols" | python3 -c "
import json, sys
data = json.load(sys.stdin)
limit = $LIMIT
results = []
for p in data:
    sol_tvl = (p.get('chainTvls') or {}).get('Solana', 0)
    if sol_tvl and sol_tvl > 1000000 and p.get('category') not in ['CEX','Chain',None]:
        results.append({
            'name': p['name'],
            'cat': p.get('category','Protocol'),
            'tvl': sol_tvl,
            'd1': p.get('change_1d') or 0,
            'd7': p.get('change_7d') or 0
        })
results.sort(key=lambda x: x['tvl'], reverse=True)
for r in results[:limit]:
    tvl = round(r['tvl']/1e6, 1)
    d1 = round(float(r['d1']),1)
    d7 = round(float(r['d7']),1)
    print(f\"  [{r['cat']}] {r['name']} | TVL: USD {tvl}M | 1d: {d1}% | 7d: {d7}%\")
" 2>/dev/null || echo "  ERROR fetching TVL data"

echo ""

# 3. Solana protocols by fees + revenue
echo "--- TOP $LIMIT SOLANA PROTOCOLS BY 24H FEES (DeFiLlama) ---"
curl -s "https://api.llama.fi/overview/fees/Solana?excludeTotalDataChart=true" | python3 -c "
import json, sys
data = json.load(sys.stdin)
limit = $LIMIT
protocols = sorted(data.get('protocols',[]), key=lambda x: x.get('total24h') or 0, reverse=True)
for p in protocols[:limit]:
    fees = round((p.get('total24h') or 0)/1000, 1)
    rev  = round((p.get('revenue24h') or 0)/1000, 1)
    chg  = round(p.get('change_1d') or 0, 1)
    rev_str = f' | Revenue: USD {rev}K' if rev > 0 else ''
    print(f\"  {p['name']} | Fees: USD {fees}K | 1d: {chg}%{rev_str}\")
" 2>/dev/null || echo "  ERROR fetching fee data"

echo ""
echo "=== END ==="
