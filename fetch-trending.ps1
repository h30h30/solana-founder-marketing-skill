# fetch-trending.ps1
param([int]$Limit = 10)

$timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm'

Write-Host "=== LIVE MARKET DATA ===" -ForegroundColor Cyan
Write-Host "Fetched: $timestamp"
Write-Host ""

# 1. CoinGecko trending tokens
try {
    $tokens = Invoke-RestMethod -Uri "https://api.coingecko.com/api/v3/search/trending"
    Write-Host "--- TOP $Limit TRENDING TOKENS (most searched on CoinGecko) ---"
    $i = 0
    foreach ($c in $tokens.coins) {
        if ($i -ge $Limit) { break }
        $name   = $c.item.name
        $symbol = $c.item.symbol
        $mcRank = $c.item.market_cap_rank
        $mcRankStr = if (-not $mcRank) { "unranked" } else { "No.$mcRank" }
        $priceRaw = $c.item.data.price
        if ($priceRaw) {
            $price = [double]$priceRaw
            if ($price -ge 1) { $priceStr = "USD " + [math]::Round($price, 2) }
            elseif ($price -ge 0.01) { $priceStr = "USD " + [math]::Round($price, 4) }
            else { $priceStr = "USD " + [math]::Round($price, 6) }
        } else { $priceStr = "N/A" }
        $chgRaw = $c.item.data.price_change_percentage_24h.usd
        $chgStr = if ($chgRaw) { [math]::Round([double]$chgRaw, 1).ToString() + "%" } else { "N/A" }
        Write-Host "  $name ($symbol) | Price: $priceStr | MCap Rank: $mcRankStr | 24h: $chgStr"
        $i++
    }
} catch {
    Write-Host "  ERROR: $_" -ForegroundColor Red
}

Write-Host ""

# 2. Solana protocols by TVL (all categories)
try {
    Write-Host "--- TOP $Limit SOLANA PROTOCOLS BY TVL (all categories, DeFiLlama) ---"
    $all = Invoke-RestMethod -Uri "https://api.llama.fi/protocols"
    $results = @()
    foreach ($p in $all) {
        $solanaTvl = $null
        if ($p.chainTvls -and $p.chainTvls.PSObject.Properties["Solana"]) {
            $solanaTvl = [double]$p.chainTvls.Solana
        }
        if ($solanaTvl -and $solanaTvl -gt 1000000 -and
            $p.category -ne "CEX" -and $p.category -ne "Chain") {
            $results += [PSCustomObject]@{
                name      = $p.name
                category  = if ($p.category) { $p.category } else { "Protocol" }
                solanaTvl = $solanaTvl
                change1d  = $p.change_1d
                change7d  = $p.change_7d
            }
        }
    }
    $sorted = $results | Sort-Object { $_.solanaTvl } -Descending | Select-Object -First $Limit
    foreach ($p in $sorted) {
        $tvl  = [math]::Round($p.solanaTvl / 1000000, 1)
        $ch1d = if ($p.change1d) { [math]::Round([double]$p.change1d, 1).ToString() + "%" } else { "N/A" }
        $ch7d = if ($p.change7d) { [math]::Round([double]$p.change7d, 1).ToString() + "%" } else { "N/A" }
        Write-Host "  [$($p.category)] $($p.name) | TVL: USD $tvl`M | 1d: $ch1d | 7d: $ch7d"
    }
} catch {
    Write-Host "  ERROR: $_" -ForegroundColor Red
}

Write-Host ""

# 3. Solana protocols by Fees + Revenue
try {
    Write-Host "--- TOP $Limit SOLANA PROTOCOLS BY 24H FEES + REVENUE (DeFiLlama) ---"
    $feeData = Invoke-RestMethod -Uri "https://api.llama.fi/overview/fees/Solana?excludeTotalDataChart=true"

    $feeResults = @()
    foreach ($p in $feeData.protocols) {
        if ($p.total24h -gt 0) {
            $feeResults += [PSCustomObject]@{
                name      = $p.name
                fees24h   = [double]$p.total24h
                rev24h    = if ($p.revenue24h) { [double]$p.revenue24h } else { 0 }
                change1d  = $p.change_1d
            }
        }
    }

    $sortedFees = $feeResults | Sort-Object { $_.fees24h } -Descending | Select-Object -First $Limit
    foreach ($p in $sortedFees) {
        $fees = [math]::Round($p.fees24h / 1000, 1)
        $rev  = [math]::Round($p.rev24h / 1000, 1)
        $ch1d = if ($p.change1d) { [math]::Round([double]$p.change1d, 1).ToString() + "%" } else { "N/A" }
        $revStr = if ($p.rev24h -gt 0) { " | Revenue: USD $rev`K" } else { "" }
        Write-Host "  $($p.name) | Fees: USD $fees`K | 1d: $ch1d$revStr"
    }
} catch {
    Write-Host "  ERROR: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== END ===" -ForegroundColor Cyan
