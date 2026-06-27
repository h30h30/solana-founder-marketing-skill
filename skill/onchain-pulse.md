# On-Chain Pulse — Program Activity via Helius

Fetches real transaction and wallet activity for any Solana program.
Requires a free Helius API key (1M credits/month).

Get your free key at: https://dev.helius.xyz

---

## CRITICAL RULES

Rule 1: If the user has not provided a Helius API key, ask for it first.
Rule 2: If the user has not provided a program ID, ask for it.
Rule 3: Fetch directly using the endpoints below. Never search Google.

---

## Setup

```powershell
# Set your key once per session
$HELIUS_KEY = "your-api-key-here"
$PROGRAM_ID = "your-program-id-here"
```

---

## Endpoint 1: Recent Transactions for a Program

```
https://api.helius.xyz/v0/addresses/{program_id}/transactions?api-key={key}&limit=100
```

**Windows PowerShell:**
```powershell
$txs = Invoke-RestMethod -Uri "https://api.helius.xyz/v0/addresses/$PROGRAM_ID/transactions?api-key=$HELIUS_KEY&limit=100"

# Unique wallets in last 100 txs
$uniqueWallets = ($txs | ForEach-Object { $_.feePayer } | Sort-Object -Unique).Count
Write-Host "Unique wallets (last 100 txs): $uniqueWallets"

# Transaction types breakdown
$types = $txs | Group-Object { $_.type } | Sort-Object Count -Descending
Write-Host "Transaction types:"
$types | ForEach-Object { Write-Host "  $($_.Name): $($_.Count)" }

# Most recent transaction timestamp
$latest = $txs[0].timestamp
$latestDate = [DateTimeOffset]::FromUnixTimeSeconds($latest).DateTime
Write-Host "Most recent tx: $latestDate UTC"
```

---

## Endpoint 2: Token Holders for an SPL Token

```
https://api.helius.xyz/v0/addresses/{mint}/holders?api-key={key}
```

**Windows PowerShell:**
```powershell
$MINT = "your-token-mint-here"
$holders = Invoke-RestMethod -Uri "https://api.helius.xyz/v0/addresses/$MINT/holders?api-key=$HELIUS_KEY"

$totalHolders = $holders.total
Write-Host "Total token holders: $totalHolders"

# Top 10 holders concentration
$top10 = $holders.holders | Select-Object -First 10
$top10Supply = ($top10 | ForEach-Object { [double]$_.balance } | Measure-Object -Sum).Sum
Write-Host "Top 10 holders control: (calculate % of total supply)"
```

---

## Endpoint 3: Wallet Activity Analysis

Use this to analyze your most active users or competitor LP holders:

```
https://api.helius.xyz/v0/addresses/{wallet}/transactions?api-key={key}&limit=50
```

**Use case:** Find wallets that hold competitor LP tokens, then analyze
what else they do — these are your target users.

```powershell
$WALLET = "wallet-address-here"
$walletTxs = Invoke-RestMethod -Uri "https://api.helius.xyz/v0/addresses/$WALLET/transactions?api-key=$HELIUS_KEY&limit=50"

# Programs this wallet interacts with
$programs = $walletTxs |
    ForEach-Object { $_.instructions } |
    ForEach-Object { $_.programId } |
    Sort-Object -Unique

Write-Host "Programs this wallet uses:"
$programs | ForEach-Object { Write-Host "  $_" }
```

---

## How to Interpret Results

### Transaction Volume Signals

| Unique wallets / 100 txs | Assessment                                    |
|--------------------------|-----------------------------------------------|
| > 80                     | Very diverse user base — healthy organic use  |
| 50–80                    | Moderate diversity — some power users         |
| 20–50                    | Concentrated — few wallets dominate activity  |
| < 20                     | Bot activity likely or very early stage       |

### Token Holder Concentration Signals

| Top 10 holders % | Assessment                                      |
|------------------|-------------------------------------------------|
| < 20%            | Well distributed — community-owned feel         |
| 20–40%           | Moderate concentration — acceptable at launch   |
| 40–60%           | High concentration — VC/team dump risk          |
| > 60%            | Extreme concentration — red flag for investors  |

### Program Health Signals

| Signal                          | What It Means                            |
|---------------------------------|------------------------------------------|
| Many unique wallets per 100 txs | Organic, diverse usage                   |
| Few wallet types but high volume| Bot or aggregator — not real user base   |
| TRANSFER type dominates         | Speculation, not protocol utility        |
| SWAP/STAKE type dominates       | Real protocol engagement                 |
| Last tx > 7 days ago            | Protocol may be inactive                 |

---

## Competitor Intelligence Use Case

To find your target users from a competitor:

1. Get competitor's LP token mint address (from their docs or Explorer)
2. Fetch their top holders
3. Analyze each holder's wallet activity
4. Find which other protocols they use
5. Go where they already are

```powershell
# Step 1: Get competitor LP holders
$compHolders = Invoke-RestMethod -Uri "https://api.helius.xyz/v0/addresses/$COMPETITOR_LP_MINT/holders?api-key=$HELIUS_KEY"
$targetWallets = $compHolders.holders | Select-Object -First 20

# Step 2: Analyze each wallet
foreach ($w in $targetWallets) {
    $addr = $w.owner
    $txs = Invoke-RestMethod -Uri "https://api.helius.xyz/v0/addresses/$addr/transactions?api-key=$HELIUS_KEY&limit=20"
    $programs = $txs | ForEach-Object { $_.instructions.programId } | Sort-Object -Unique
    Write-Host "Wallet $addr uses: $($programs -join ', ')"
}
```

---

## Response Format

```
ON-CHAIN PULSE — [Protocol/Token Name]
Date: [today]
Program ID: [address]

ACTIVITY SUMMARY:
Unique wallets (last 100 txs): [X]
Most common tx type: [type]
Last transaction: [date]
Assessment: [Very Active / Active / Moderate / Low / Inactive]

TOKEN HOLDER ANALYSIS (if mint provided):
Total holders: [X]
Top 10 concentration: [X]%
Assessment: [Well Distributed / Moderate / Concentrated / Extreme]

KEY INSIGHT:
[One actionable observation from the data]

RECOMMENDED ACTION:
[What the founder should do based on this data]
```
