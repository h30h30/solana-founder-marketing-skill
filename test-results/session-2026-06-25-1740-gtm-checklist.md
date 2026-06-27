# Test Session Log
**Skill tested:** gtm-checklist
**AI tool:** Gemini CLI
**Timestamp:** 2026-06-25 17:40
**Log file:** test-results\session-2026-06-25-1740.md

---

## Live Data Fetched

None

---

## Prompt Sent to AI

q1: We just launched on mainnet 2 days ago with 200 wallets.
What should my top 5 priorities be for the next 30 days?
q2:Our biggest bottleneck right now is user retention. What should we focus on to fix this?

---

## AI Response

✦ Congratulations on the mainnet launch. 200 wallets in 48 hours is a solid signal, but the "retention cliff" often
  happens at Day 7. Your focus must shift immediately from acquisition to retention.

  Based on gtm-checklist.md, here are your top 5 priorities for the next 30 days:

  1. Retention Audit (The "3x Swap" Metric)
  Stop looking at your total wallet count. Your #1 metric is: How many of these 200 wallets have completed 3+ swaps in
  the last 48 hours?
   * Action: If this number is < 20%, your UX or liquidity is preventing repeat usage. If it's > 40%, you have
     product-market fit.
   * Metric: 30-day retention rate of wallets that swapped > 1 time.

  2. Direct Outreach to Power Users
  You have 200 wallets. You can afford to be manual.
   * Action: Use Helius to identify the top 10 wallets by transaction volume/frequency. DM them (on X/Discord)
     personally. Ask: "What was the specific moment you decided to use our DEX instead of [Competitor]?"
   * Goal: Learn the real reason they chose you, and double down on that specific feature in your marketing copy.

  3. Data Transparency (Dune Dashboard)
  Solana users demand on-chain proof. A professional, public dashboard is your best marketing tool.
   * Action: Build a simple Dune (https://dune.com) dashboard tracking: Total Volume, Unique Active Wallets, and the
     LST-pair dominance.
   * Goal: Credibility. When you pitch for grants or integrations, link to this dashboard instead of sending a slide
     deck.

  4. Optimize the "80/20" Pairs
   * Action: Determine which LST pairs are driving 80% of your current volume.
   * Goal: Focus all UI/UX improvements, liquidity incentives, and community messaging on those specific pairs. If
     JitoSOL/SOL is driving volume, don't waste time marketing minor/obscure LST pairs right now.

  5. Prepare for Ecosystem Grants
  Most major Solana grants (Jupiter, Solana Foundation, etc.) require a minimum of 30 days of mainnet history to apply.
   * Action: Start the paperwork now. Prepare your "State of Protocol — Month 1" report based on the data from your Dune
     dashboard.
   * Goal: Be ready to submit on Day 31 with a proven track record of on-chain traction.
 Addressing User Retention Bottleneck:
  I am focusing on the user's biggest bottleneck: user retention. My goal is to provide a concrete, data-driven plan
  to diagnose and fix the "retention cliff" for their new DEX.


✦ Retention is the silent killer of early-stage DEXs. If users come once to explore but don't come back, your UX or your
  pricing (slippage/fees) is failing them.

  Here is your 30-day "Stop the Leak" plan:

  1. The "First Session" Reconstruction
  You need to see exactly what they experienced.
   * Action: Take your 200 wallets and tag them as "New Users."
   * The Diagnostic: Identify the wallets that performed only 1 swap and never returned. Use the Helius tool (Endpoint 3
     in onchain-pulse.md) to check what those wallets did immediately after their swap on your DEX.
   * The "Aha!" Moment: Did they immediately go to another DEX (like Jupiter or Raydium)? If so, they were shopping for
     better price/liquidity. If they stopped using Solana entirely for a few hours, your UI/UX was too frustrating.

  2. Immediate UX "Friction Audit"
  If they aren't coming back, the "cost" of the swap is higher than the benefit.
   * Action: Does your DEX require multiple wallet approvals for a simple LST swap?
   * The Benchmark: On Solana, a single swap should be one wallet approval. If you require approvals for "wrap,"
     "approve," and "swap" as distinct steps, you are losing 50% of your users in the first minute.

  3. The "LST-Specific" Hook
  Why did they swap LSTs on your DEX instead of just using Jupiter's aggregator?
   * Hypothesis: If you don't offer better pricing than a Jupiter aggregator, you must offer something else:
     yield-on-the-spot or instant liquidity for specific, hard-to-swap LST pairs.
   * If retention is your bottleneck, your users are likely experiencing "friction on the path to value"** (i.e., they
     come, they try, they find the experience too hard, too slow, or not worth the effort compared to established DEXs).

  Since you are a new DEX, you don't have a "brand" yet, only Utility.

  Here is the 3-step diagnostic plan for the next 7 days to stop the churn.

  Step 1: Immediate On-Chain Diagnosis
  We need to know what they are doing when they leave. We will use the Helius logic to profile your "one-and-done"
  users.

   1. Identify: Find the ~160 wallets that interacted with your program exactly once.
   2. Analyze: Use Helius to inspect those specific 160 wallets.
       * What other programs are they using? (If they are heavy Jupiter/Orca users, they are sophisticated and will
         churn if your slippage/UI is subpar.)
       * What was their last transaction? (Did they approve an allowance but fail to swap? Did they try to swap a pair
         you don't actually have liquidity for?)

  Action: If you provide your Program ID and Helius API key, I can run a script to pull the instructions for a sample of
  these "one-and-done" wallets to see exactly where they failed.

  Step 2: The "Friction" Audit (Manual UX Check)
  Forget the "vision" of your product. Perform this audit right now:

   * The 3-Click Test: How many clicks does it take from landing on your site to having a swapped LST in their wallet?
     If it is > 3, you are losing 50%+ of your traffic.
   * The "Price Check" Test: Go to Jupiter, then go to your site. Is your price worse? By how much? If the spread is >
     0.5% compared to Jupiter, users will not come back unless you have a "yield-boost" feature that compensates for
     that loss.

  Step 3: Direct "Win-Back" Outreach
  Don't just email them; reach out where they live.

   * Action: If you are tracking wallets, check if they are part of a specific DAO or community on X.
   * The Script: Don't ask "How are we doing?" Ask, "I saw you tried [DEX Name] yesterday. We're optimized for [Specific
     LST Pair]. Did you hit an error, or was our price not competitive enough?"
   * Goal: You want the brutal truth. You don't need "happy" users right now; you need to hear why they went back to
     Jupiter or Orca.

  ---

  Immediate Next Step:
  Would you like me to create a script to fetch the transaction history of your last 20 active wallets? We can analyze
  what other programs they are interacting with to understand if you are capturing "new" users or just "secondary" DEX
  users who are testing you out.

---

## Notes

Model: gemini-3.1-flash-lite

---
Generated by save-session.ps1
