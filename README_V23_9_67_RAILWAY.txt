LECHART JAMES V23.9.67 — RAILWAY COINBASE MACHINE TRADER
==========================================================

WHAT THIS IS
------------
This is the mobile/Railway port of the V23.9.66 Machine Trader behavior.
It starts from the proven V23.9.32 Railway Coinbase OG cloud lineage and adds
the current autonomous trader stack. Bookmap is NOT required and is not used as
a market-data authority in this build.

MARKET-DATA ROLES
-----------------
• Coinbase BTC/USD public WebSocket: primary live underlying price + executed trades.
• Coinbase direct 1m candles / REST: chart/history/self-healing fallback.
• Kalshi live BBO: executable UP/DOWN contract prices and live orders.
• Kalshi BRTI (when authenticated): official settlement-reference stream / final-minute average.
• If BRTI is temporarily unavailable, the Machine labels Coinbase as a conservative GUIDE fallback.

MACHINE TRADER FEATURES
-----------------------
• James MAIN / EMERGENCY lock remains CORE direction authority.
• Autonomous fair-value / edge entry by default.
• Optional manual entry-zone toggle.
• CORE thesis-survival engine with HOLD SHIELD.
• No autonomous fixed-cent CORE stop when manual TP/SL rails are OFF.
• Sustained multi-family COOKED invalidation with anti-churn debounce.
• FAST ALPHA scalp engine while flat, including counter-side scalps.
• SCALP -> CORE promotion if James later aligns strongly.
• Same-lock value-reset re-entry after profit exits.
• Same-lock recovery re-entry after true invalidation only after real thesis recovery.
• Coinbase executed-flow persistence, surprise, impact and absorption fusion.
• CUSUM-like online change detector.
• Persistent meta-learning statistics on a Railway volume.
• Auto sizing bounded by your Max Stake setting.
• Sequential IOC order submission; confirmed zero-fill rearms.
• Ambiguous network failures are reconciled by client_order_id before any retry.
• Actual fills endpoint is used to recover weighted contract fill price.
• Exact Kalshi WS orderbook BBO is preferred; REST/ticker is recovery only.
• Mobile web command center exposes the Machine Mind + controls.

DEPLOY
------
1. Put these files at your Railway repo root:
   - LECHART_JAMES_V23_9_67_RAILWAY_COINBASE_MACHINE.py
   - Dockerfile
   - railway.toml
   - requirements.txt

2. Deploy. Railway supplies PORT automatically. The server binds to 0.0.0.0:$PORT.

3. Recommended: attach a Railway persistent volume at /data.
   The Machine stores:
   /data/LECHART_RAILWAY_MACHINE_V23967.jsonl
   /data/LECHART_RAILWAY_MACHINE_V23967_META.json

OPTIONAL RAILWAY VARIABLES
--------------------------
KALSHI_API_KEY_ID=your-key-id
KALSHI_PRIVATE_KEY_PEM=-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----

Instead of putting the private key in environment variables, you can paste it into
the credential box on the private mobile page and press VERIFY. The web API never
returns the private key to the browser after submission.

Strongly recommended for a publicly reachable Railway deployment:
LECHART_CONTROL_TOKEN=a-long-random-secret

When LECHART_CONTROL_TOKEN is set, the phone control POST endpoints require the
same token. Enter it once in the phone UI; Safari/localStorage remembers it.

Optional tuning:
LECHART_MAX_ROUND_FILLS=8
LECHART_MACHINE_TICK_MS=90
RAILWAY_VOLUME_MOUNT_PATH=/data

LIVE-TRADING DEFAULT
--------------------
LIVE AUTO ALWAYS BOOTS DISARMED.
Verify credentials, review Max Stake / toggles, then tap ARM LIVE AUTO.

Default Machine settings:
• Manual entry zone: OFF
• Manual TP/SL rails: OFF
• FAST scalps: ON
• Auto size: ON
• Max stake: $10 (budget ceiling, not guaranteed amount per trade)

IMPORTANT BEHAVIOR
------------------
CORE does NOT exit just because Kalshi odds fall. It can HOLD THROUGH DRAWDOWN
when James's lock and Coinbase/BRTI/microstructure evidence say the thesis is alive.
It exits after sustained thesis invalidation, a genuine opposite lock, or a
profit-harvest/trail condition that is also accompanied by thesis deterioration.
FAST SCALPS are intentionally quicker and are managed on their own alpha half-life.

No real Kalshi orders were placed while packaging/testing this build.
