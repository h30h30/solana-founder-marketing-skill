#!/bin/bash
# install.sh — solana-founder-marketing-skill installer
# Compatible with solana-ai-kit (https://github.com/solanabr/solana-ai-kit)
# Usage: bash install.sh [--agents]

set -e

# Support --agents flag for non-Claude tools
if [ "$1" = "--agents" ]; then
  BASE_DIR=".agents"
else
  BASE_DIR=".claude"
fi

SKILL_DIR="$BASE_DIR/skills/solana-founder-marketing"
COMMANDS_DIR="$BASE_DIR/commands"
AGENTS_DIR="$BASE_DIR/agents"

echo "Installing solana-founder-marketing-skill into $BASE_DIR/..."

# Create directories
mkdir -p "$SKILL_DIR"
mkdir -p "$COMMANDS_DIR"
mkdir -p "$AGENTS_DIR"

# Copy skill files
cp -r skill/* "$SKILL_DIR/"

# Copy commands
cp commands/analyze-market.md "$COMMANDS_DIR/"
cp commands/audit-project.md "$COMMANDS_DIR/"

# Copy agents
cp agents/gtm-advisor.md "$AGENTS_DIR/"

# Copy fetch scripts to project root if not already there
if [ ! -f "fetch-trending.sh" ]; then
  cp fetch-trending.sh . 2>/dev/null || true
fi
if [ ! -f "analyze-github.ps1" ]; then
  cp analyze-github.ps1 . 2>/dev/null || true
fi

# Register in master SKILL.md if kit is installed
MASTER_SKILL="$BASE_DIR/skills/SKILL.md"
if [ -f "$MASTER_SKILL" ]; then
  if ! grep -q "solana-founder-marketing" "$MASTER_SKILL"; then
    echo "" >> "$MASTER_SKILL"
    echo "## Founder Marketing (GTM Intelligence)" >> "$MASTER_SKILL"
    echo "Skills: \`.claude/skills/solana-founder-marketing/SKILL.md\`" >> "$MASTER_SKILL"
    echo "Use for: market intelligence, competitive analysis, GitHub analysis, tokenomics audit, launch planning" >> "$MASTER_SKILL"
    echo "Registered in master SKILL.md"
  fi
else
  echo ""
  echo "Note: No master SKILL.md found."
  echo "Add this to your CLAUDE.md manually:"
  echo "  Skills: .claude/skills/solana-founder-marketing/SKILL.md"
fi

echo ""
echo "solana-founder-marketing-skill installed."
echo ""
echo "Try these in Claude Code:"
echo "  /analyze-market"
echo "  /audit-project"
echo "  'Analyze https://github.com/MeteoraAg'"
echo "  'What niche is underserved on Solana right now?'"
echo "  'Audit my tokenomics: Team 20%, Community 40%...'"
