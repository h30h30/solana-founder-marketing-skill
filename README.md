# solana-founder-marketing-skill

A Claude Code skill that gives Solana founders real go-to-market intelligence
grounded in live on-chain data — not generic AI advice.

---

## The Problem

Most AI tools can help founders write content. What they struggle with is
answering the harder questions: Is my market positioning actually differentiated?
Which protocol category is genuinely underserved today? Is the team I'm competing
against still actively building? What does my on-chain data actually say about
my users?

This skill is built to answer those questions using live data from CoinGecko,
DeFiLlama, GitHub, and Helius — not from training data or general knowledge.

---

## Demo

The demo below shows the skill running on Gemini CLI — one of several supported
AI tools. In Claude Code the workflow is fully automatic with no manual steps.

> 📹 [Watch demo on Loom](https://www.loom.com/share/2ace5a1c5fba4f2a878a8d185696baba)

---

## What It Can Do

The skill covers seven areas, each grounded in a different data source:

**Live market intelligence** — pulls trending tokens from CoinGecko and all
Solana protocol categories by TVL and fees from DeFiLlama to identify what
is gaining traction and where gaps exist in the market today.

**Competitive analysis** — fetches real-time TVL, volume, and fee data across
Solana protocols so you can benchmark your position against actual competitors,
not estimated numbers.

**GitHub intelligence** — analyzes any Solana project's GitHub organization or
repository using the GitHub REST API. Shows commit velocity, contributor health,
repo structure patterns, and what you can learn or avoid for your own build.

**On-chain pulse** — uses Helius RPC to inspect wallet-level activity on any
Solana program: unique wallets, transaction type breakdown, and activity signals.
Requires a free Helius API key.

**Launch checklist** — a structured pre/post mainnet checklist covering
DeFiLlama submission, Solana Foundation grants, Colosseum, Birdeye listing,
and ecosystem outreach steps with real links.

**Tokenomics audit** — evaluates token distribution, vesting schedules, and
utility design against real ecosystem benchmarks including HYPE (Hyperliquid)
and JUP (Jupiter).

---

## How It Works Across Different AI Tools

### Claude Code — Fully Automatic

Claude Code has shell access and runs data fetches automatically.
You ask a question in plain language and Claude handles everything:
fetching, filtering, and interpreting the data.

Good questions to ask Claude Code:
- What Solana protocol category is underserved right now, based on today's data?
- Analyze the GitHub org at [URL] and tell me what I can learn for my own repo
- Compare TVL and fee revenue across the top Solana lending protocols
- Audit my tokenomics — [share your distribution and vesting]
- What should I prioritize in the next 4 weeks before mainnet launch?

The skill works best when questions are specific. Vague questions like
"how do I market my protocol" will get generic answers. Questions grounded
in your specific situation — your token allocation, your competitor's GitHub,
your program ID — get data-driven answers.

### Other AI Tools (Cursor, Windsurf, other CLIs)

Tools without automatic shell access need a manual pre-fetch step.
This is where the helper scripts come in.

**`fetch-trending.ps1` / `fetch-trending.sh`** — fetches live market data
from CoinGecko and DeFiLlama, filters it down to the top 10 items per
category, and prints a compact summary. You run this in a terminal window,
copy the output, and paste it into your AI session alongside your question.
Without this step, the AI has no live data to work with and will either
fetch raw API responses (slow, large) or fall back to general knowledge.

**`analyze-github.ps1`** — does the same for GitHub analysis. Provide
an org name or repo path, the script fetches commit activity, contributors,
and repo metadata via the GitHub REST API, and prints a structured summary
ready to paste. This is important because most AI tools, when given a
`github.com` URL, will try to browse the HTML page instead of calling
the API — which is slow and returns little useful data.

**`save-session.ps1`** — a session logger. After any test conversation,
run this script, paste your live data, prompt, and AI response when asked,
and it saves everything as a timestamped markdown file in `test-results/`.
Useful for documenting what the skill actually produced during testing.

In Claude Code, none of these scripts need to be run manually — Claude Code
has shell access and handles all of this automatically behind the scenes.

---

## Commands and Agent

Three structured entry points are available in Claude Code:

`/analyze-market` — triggers a live data fetch and produces a market
opportunity report showing trending tokens, active protocol categories,
fee leaders, and identified gaps.

`/audit-project` — a guided session that collects your project details
step by step and runs relevant skill files across positioning, tokenomics,
and GitHub if you have a repo.

`gtm-advisor` — a specialized agent for multi-step conversations. Invoke
it when you want to work through a specific topic in depth rather than
get a one-shot answer.

---

## Install

### With the Solana AI Kit:
```bash
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/solana-founder-marketing-skill/main/install.sh | bash
```

### Standalone:
```bash
git clone https://github.com/YOUR_USERNAME/solana-founder-marketing-skill.git
cd solana-founder-marketing-skill
bash install.sh
```

### With --agents flag (non-Claude tools):
```bash
bash install.sh --agents
```

---

## API Keys

Only one skill requires an API key:

`onchain-pulse` uses Helius RPC for wallet-level on-chain data.
Get a free key at https://dev.helius.xyz — the free tier includes
1M credits per month which is sufficient for most use cases.

Provide it directly in your prompt:
```
Check on-chain pulse for my program.
Helius API key: YOUR_KEY
Program ID: YOUR_PROGRAM_ID
```

Never commit your Helius key to GitHub.

All other skills use public APIs with no key required.

---

## Data Sources

| Source | What It Provides | Cost |
|--------|-----------------|------|
| CoinGecko `/search/trending` | Top trending tokens globally | Free, no key |
| DeFiLlama `/protocols` | TVL across all Solana protocol categories | Free, no key |
| DeFiLlama `/overview/fees/Solana` | Protocol fee + revenue rankings | Free, no key |
| GitHub API | Commit activity, contributors, repo health | Free, no key |
| Helius RPC | Wallet-level on-chain transaction analysis | Free tier (1M credits/mo) |

---

## Example Outputs

### Market Intelligence

```
MARKET INTELLIGENCE REPORT (2026-06-25)

TRENDING TOKENS: ZANO (privacy), VVV (AI privacy), PENGU/CARDS (collectibles)
TOP PROTOCOLS BY TVL: Kamino Lend $1.06B, Jupiter Lend $860M, Raydium $803M
TOP PROTOCOLS BY FEES: PumpSwap $1.4M/24h, Meteora $290K, Raydium $154K

GAP IDENTIFIED:
Privacy tokens trending but zero top-10 Solana protocols specialize
in privacy-preserving DeFi infrastructure.

POSITIONING ANGLE:
"The secure liquidity hub for Solana's privacy-sovereign asset class."

CONFIDENCE: Medium
REASON: Demand signal is real but category is early — validate before building.
```

### GitHub Intelligence

```
GITHUB ANALYSIS — Meteora (MeteoraAg)
Repos: 30 total (23 own + 7 forks) | Total org forks: 583
Selected: damm-v2 (most recently pushed non-fork)

Language: TypeScript | Stars: 112 | Forks: 81
Last push: 2026-06-26 | Human contributors: 5
Status: Very Active

IF YOU WANT TO BUILD SOMETHING SIMILAR:
KEEP: Modular structure — core program and SDK in separate repos,
      dedicated audits repo builds trust before users ask for it
IMPROVE: 5 contributors is healthy but creates key-person risk
AVOID: Coupling program logic and client SDK — Meteora separated these early
```

### On-Chain Pulse

```
ON-CHAIN PULSE — Orca Whirlpools

Unique wallets (last 100 txs): 55
Most common tx type: SWAP (63%)
Last transaction: 2026-06-25 05:22 UTC
Assessment: Active — healthy organic diversity
```

> All outputs above came from live data fetched at the time of the session.
> See `test-results/` for timestamped logs of real test sessions.

---

## Logging Test Sessions

`save-session.ps1` (Windows) logs any test session as a readable markdown file,
covering all skills, commands, and the agent.

```powershell
powershell -ExecutionPolicy Bypass -File save-session.ps1
```

Logs are saved to `test-results/session-YYYY-MM-DD-HHmm.md`.

---

## File Structure

```
solana-founder-marketing-skill/
├── install.sh
├── fetch-trending.ps1        # Windows — market data fetch
├── fetch-trending.sh         # Mac/Linux — market data fetch
├── analyze-github.ps1        # Windows — GitHub data fetch
├── save-session.ps1          # Windows — session logger
├── README.md
├── LICENSE
├── skill/
│   ├── SKILL.md
│   ├── market-intelligence.md
│   ├── competitive-analysis.md
│   ├── github-intelligence.md
│   ├── onchain-pulse.md
│   ├── gtm-checklist.md
│   └── tokenomics-audit.md
├── commands/
│   ├── analyze-market.md
│   └── audit-project.md
└── agents/
    └── gtm-advisor.md
```

---

## License

MIT
