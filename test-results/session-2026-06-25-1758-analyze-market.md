# Test Session Log
**Skill tested:** /analyze-market command
**AI tool:** Gemini CLI
**Timestamp:** 2026-06-25 17:58
**Log file:** test-results\session-2026-06-25-1758.md

---

## Live Data Fetched

=== LIVE MARKET DATA ===
Fetched: 2026-06-25 17:59

--- TOP 10 TRENDING TOKENS (most searched on CoinGecko) ---
  Bitcoin (BTC) | Price: USD 59304.06 | MCap Rank: No.1 | 24h: -3%
  Synapse (SYN) | Price: USD 0.4485 | MCap Rank: No.263 | 24h: 33.7%
  Solana (SOL) | Price: USD 65.74 | MCap Rank: No.7 | 24h: -4.3%
  Hyperliquid (HYPE) | Price: USD 60.44 | MCap Rank: No.10 | 24h: 0.1%
  Solstice (SLX) | Price: USD 0.3861 | MCap Rank: No.272 | 24h: 43.7%
  Ethereum (ETH) | Price: USD 1562.75 | MCap Rank: No.2 | 24h: -5%
  Collector Crypt (CARDS) | Price: USD 0.3032 | MCap Rank: No.304 | 24h: 8%
  Pudgy Penguins (PENGU) | Price: USD 0.005792 | MCap Rank: No.118 | 24h: -4.2%
  MemeCore (M) | Price: USD 0.8546 | MCap Rank: No.61 | 24h: -69.6%
  XRP (XRP) | Price: USD 1.03 | MCap Rank: No.6 | 24h: -3.8%

--- TOP 10 SOLANA PROTOCOLS BY TVL (all categories, DeFiLlama) ---
  [Lending] Kamino Lend | TVL: USD 1065.3M | 1d: -1.1% | 7d: -2.6%
  [Liquid Staking] Sanctum Validator LSTs | TVL: USD 982.3M | 1d: -2.4% | 7d: -6.5%
  [Lending] Jupiter Lend | TVL: USD 864.4M | 1d: -0.7% | 7d: -2.7%
  [Dexs] Raydium AMM | TVL: USD 807.1M | 1d: -2% | 7d: -4.1%
  [Liquid Staking] Binance Staked SOL | TVL: USD 706M | 1d: -2.3% | 7d: -7.3%
  [Liquid Staking] Jito Liquid Staking | TVL: USD 671.3M | 1d: -2.1% | 7d: -4.4%
  [Derivatives] Jupiter Perpetual Exchange | TVL: USD 663.5M | 1d: -1.7% | 7d: -1.8%
  [RWA] BlackRock BUIDL | TVL: USD 615.9M | 1d: 1.6% | 7d: 1.1%
  [RWA] xStocks | TVL: USD 581.3M | 1d: -1.1% | 7d: 14.2%
  [Basis Trading] Solstice | TVL: USD 505.3M | 1d: 0% | 7d: -0.5%

--- TOP 10 SOLANA PROTOCOLS BY 24H FEES + REVENUE (DeFiLlama) ---
  PumpSwap | Fees: USD 1290.9K | 1d: -8.1%
  pump.fun | Fees: USD 725.2K | 1d: -6.7%
  Jupiter Perpetual Exchange | Fees: USD 594.7K | 1d: 65.6%
  Axiom | Fees: USD 364.1K | 1d: -8.5%
  Solana | Fees: USD 360.9K | 1d: -4.8%
  Meteora DLMM | Fees: USD 345.3K | 1d: -13.3%
  Sanctum Validator LSTs | Fees: USD 332.4K | 1d: 1214.1%
  Binance Staked SOL | Fees: USD 236.6K | 1d: 43384.2%
  Collector Crypt | Fees: USD 201.8K | 1d: -68.8%
  Jito Liquid Staking | Fees: USD 186.2K | 1d: N/A

=== END ===

---

## Prompt Sent to AI

/analyze-market (it's a command based tool)

---

## AI Response

  Analyzing Market Opportunity:
  I am executing the /analyze-market command. As I do not have live market data in the chat history, I must ask the
  user to provide the output of `fetch-trending.ps1` as required by the `solana-founder-marketing` skill rules.


✦ To analyze market opportunities using the /analyze-market command, I require current data to ensure my recommendations
  are grounded in reality rather than speculation.

  Please run the fetch-trending.ps1 script provided in your workspace and paste the output here.

  Once you provide that data, I will:
   1. Identify high-growth segments versus saturated segments.
   2. Highlight specific token pairs or protocols gaining traction.
   3. Recommend where your LST-focused DEX can capture market share based on current trends.
(Pasted live data here)
  Market Opportunity Analysis: LST DEX Positioning:
  I am performing a market opportunity analysis for an LST-focused DEX based on the provided live market data. My
  goal is to synthesize this data to highlight actionable entry points, differentiate from high-TVL competitors, and
  refine the user's positioning.


✦ Market Opportunity Analysis (based on live data)

  The data shows a massive, underserved opportunity for an LST-focused DEX, but also highlights exactly where you should
  not compete.

  1. The Landscape (The Data-Backed View)
   * The Giants: [Liquid Staking] protocols (Sanctum, Jito, Binance) account for ~25% of the Top 10 TVL on Solana. Users
     are parking billions in LSTs, but swapping them is currently fragmented across aggregators (Jupiter) and
     general-purpose AMMs (Raydium, Meteora).
   * The "Yield-Fee" Spike: Note the massive fee spikes in [Liquid Staking] protocols: Sanctum (+1214.1%) and Binance
     Staked SOL (+43384.2%). This is an anomaly—it indicates sudden, massive volume in LST exchanges or rebalancing.
   * The Competition: You are not competing against "other DEXs." You are competing for the volume currently being
     harvested by Meteora DLMM ($345K fees) and Jupiter Perpetual Exchange ($594K fees).

  2. Where You Fail (Don't do this)
   * Do not position as a general-purpose AMM. Raydium ($807M TVL) and Jupiter already own "general-purpose" swapping.
   * Do not try to compete on "Fees" alone. Users care about execution price (slippage) more than the fee itself.

  3. Where You Win (The "LST-DEX" Opportunity)
  Based on the data, your entry point is "LST-Specific Liquidity Efficiency."

   * Actionable Opportunity: Create a specialized AMM pair structure optimized for LST-to-LST pairs (e.g.,
     JitoSOL/mSOL). General aggregators often struggle with liquidity depth for niche LST pairs, causing high slippage.
     If your DEX provides the lowest slippage for LST-LST pairs, you become the indispensable backend for the
     aggregators themselves.

  4. Refined Positioning
   * Old Positioning: "The best place to swap liquid staking tokens on Solana." (Generic, weak).
   * New Positioning: "The liquidity hub for the LST economy. Optimized for zero-slippage arbitrage between Solana
     liquid staking protocols."

  ---

  Immediate Action Plan

   1. Target the LST Rebalancers: The massive fee spike in Sanctum and Binance Staked SOL data confirms that users are
      actively moving between LST protocols. Build a "One-Click LST Bridge"—a tool on your site that lets a user swap
      one LST for another without having to un-stake, wait, and re-stake.
   2. Dune Dashboard Priority: Track the volume of LST-LST swaps. If you can show that your DEX provides 0.1% less
      slippage than Jupiter for specific LST pairs, that is your "killer app" to show VCs (or to win community trust).
   3. Liquidity Strategy: Reach out to the smaller validator LST teams (under $100M TVL). Offer to be their primary
      liquidity venue. They want their LSTs to be liquid, and they don't have the leverage to get deep pools on Raydium
      or Jupiter.

  Do you want me to write a query for the Dune dashboard you need to build to track this "LST-LST swap efficiency" gap?

---

## Notes

Model: gemini-3.1-flash-lite

---
Generated by save-session.ps1
