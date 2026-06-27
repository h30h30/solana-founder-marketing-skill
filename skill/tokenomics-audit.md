# Tokenomics Audit

A framework for auditing Solana token economics. The founder provides
their model — this skill audits it against ecosystem benchmarks.

---

## How to Use

Ask the founder to provide:
1. Total supply
2. Distribution breakdown (team, investors, community, treasury, liquidity)
3. Vesting schedule for each category
4. Token utility — what does it actually do?
5. Inflation/emission schedule if any

---

## Real Examples to Reference

Before auditing, understand what good looks like in practice.

### HYPE (Hyperliquid) — The Community-First Benchmark

Hyperliquid launched without selling discounted tokens to venture-capital investors. In a typical DeFi launch, early investors hold anywhere from 15% to 40% of the supply and eventually sell into the market. HYPE skipped that entirely. Around 31% of the supply was distributed to roughly 94,000 early users of the platform.

The project is self-funded with no VC backing, distributing 31% of supply to ~94,000 early users via airdrop. HYPE has a fixed 1 billion supply with deflationary mechanics — 97% of trading fees fund buybacks and HyperEVM fees are burned.

**Why it worked:**
- Zero VC allocation removed multi-year investor unlock overhang
- Fee buyback mechanism links token demand directly to protocol usage
- Community received tokens based on actual usage, not capital

### JUP (Jupiter) — The Solana Community Standard

Jupiter distributed 1 billion JUP tokens to over 1 million wallets in its first airdrop. Total supply of 10 billion JUP tokens, with 50% allocated to the community through airdrops and other initiatives.

Team vesting: the 2 billion JUP allocated to team members is subject to a one-year cliff, followed by a two-year vesting period. Strategic Reserve is locked for at least one year, and the community must be given a minimum of six months' notice before any liquidity event.

**Why it worked:**
- 50% community allocation set a high bar for Solana ecosystem norms
- Team cliff + vesting aligned incentives with long-term growth
- Annual "Jupuary" airdrops created sustained community engagement

### Key Lesson from Both

Both HYPE and JUP succeeded because token demand was tied to real usage:
- HYPE: more trading volume → more buybacks → more demand
- JUP: more swaps → more governance power → more community ownership

If your token has no mechanism linking protocol success to token demand, that is the most important thing to fix.

---

## Part 1: Distribution Audit

### Healthy Benchmarks (Solana Ecosystem, 2026)

| Category          | Healthy Range | Red Flag     | Best Example        |
|-------------------|---------------|--------------|---------------------|
| Team              | 10–20%        | > 25%        | HYPE: ~24% (team contributed 4yr) |
| Investors/VCs     | 0–20%         | > 30%        | HYPE: 0%, JUP: 0%   |
| Community/Airdrop | 30–50%        | < 20%        | JUP: 50%, HYPE: 31% |
| Treasury/DAO      | 10–25%        | < 8%         | JUP: 19% strategic reserve |
| Liquidity         | 5–15%         | < 3%         | —                   |

### Red Flags

- Team + Investors > 50% → community will notice, VCs will question
- Community < 20% → no organic growth incentive
- No vesting on any allocation → instant dump risk at TGE
- Treasury < 8% → no runway for audits, grants, or crises

---

## Part 2: Vesting Schedule Audit

### Healthy Benchmarks

| Category        | Cliff        | Vesting Duration |
|-----------------|--------------|-----------------|
| Team            | 12 months    | 36–48 months    |
| Investors       | 6–12 months  | 24–36 months    |
| Advisors        | 6 months     | 18–24 months    |
| Community       | None or 1mo  | 12–24 months    |
| Treasury        | None         | Governance-controlled |

### TGE Unlock Calculator

At launch, what % of total supply unlocks immediately?

```
TGE Unlock % = sum of (allocation% × TGE_unlock% for each category)
```

| TGE Unlock  | Assessment                              |
|-------------|----------------------------------------|
| < 10%       | Healthy — low sell pressure             |
| 10–20%      | Acceptable — monitor price action       |
| > 20%       | High sell pressure — expect price drop  |
| > 30%       | Red flag — likely dump at launch        |

### Red Flags

- Team cliff < 6 months → team can exit before product ships
- No vesting on investor allocation → instant sell pressure
- All categories unlock at the same time → coordinated dump risk
- Team vesting shorter than investor vesting → misaligned incentives

---

## Part 3: Token Utility Audit

### The Three Questions

**1. Why would someone hold this token instead of selling it?**

Acceptable answers:
- Governance over real treasury decisions with on-chain execution
- Fee discounts that compound with usage (like JUP)
- Staking yield funded by protocol revenue, not emissions
- Required for access to features that generate real value
- Buyback mechanism funded by fees (like HYPE)

Unacceptable answers:
- "Speculation" — not a utility
- "Future use cases TBD" — not launched
- "Community building" — not a utility

**2. Is the yield real or inflationary?**

| Yield Source          | Sustainability                          |
|-----------------------|----------------------------------------|
| Protocol fee revenue  | Sustainable — HYPE/JUP model           |
| Fee buybacks          | Sustainable — links token to usage     |
| Liquidity incentives  | Short-term only — mercenary capital    |
| Token emissions       | Inflationary — not sustainable         |
| Treasury grants       | Finite — plan the end date             |

**3. What happens to demand at 12 months?**

Map out: when do incentive programs end? What replaces them?
If there is no answer → the token has no long-term demand driver.

HYPE's answer: fee buybacks scale with volume forever.
JUP's answer: governance over $3.5B TVL protocol + annual airdrops.

What is your answer?

---

## Part 4: Comparable Projects on Solana

| Project   | Team  | Investors | Community | Cliff | Notable Feature              |
|-----------|-------|-----------|-----------|-------|------------------------------|
| JUP       | 20%   | 0%        | 50%       | 1yr   | Annual Jupuary airdrops      |
| HYPE      | ~24%  | 0%        | ~70%      | multi | 97% fee buyback mechanism    |
| Drift     | 15%   | 20%       | 35%       | 1yr   | Standard VC-backed model     |
| Kamino    | 12%   | 18%       | 40%       | 1yr   | Balanced distribution        |
| Marinade  | 8%    | 0%        | 60%+      | none  | DAO-native, no VCs           |

---

## Common Founder Mistakes

1. Copying tokenomics from a project without understanding why theirs worked
2. "Governance" token with no real governance decisions to make
3. Staking APY funded purely by emissions — paying holders with dilution
4. No burn or buyback mechanism despite having protocol fees
5. No explicit plan for what happens when liquidity mining ends
6. Setting team allocation based on "what feels fair" not ecosystem norms

---

## Audit Response Format

```
TOKENOMICS AUDIT — [Project Name]
Date: [today]

DISTRIBUTION SCORE: [Pass / Warning / Fail]
[One sentence on biggest distribution concern]

VESTING SCORE: [Pass / Warning / Fail]
[One sentence on biggest vesting concern]

UTILITY SCORE: [Pass / Warning / Fail]
[One sentence — does demand scale with protocol usage?]

TGE UNLOCK ESTIMATE: [X%]
Assessment: [Low / Medium / High] sell pressure

TOP 3 RED FLAGS:
1. [Most critical]
2. [Second]
3. [Third]

TOP 3 STRENGTHS:
1. [Best aspect]
2. [Second]
3. [Third]

RECOMMENDED CHANGES:
1. [Most important fix]
2. [Second fix]
3. [Third fix]

MOST SIMILAR TO: [JUP / HYPE / Drift / Kamino / Marinade] model
REASON: [One sentence]
```
