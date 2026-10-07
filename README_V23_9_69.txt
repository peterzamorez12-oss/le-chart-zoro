LECHART V23.9.69 RAILWAY COINBASE MACHINE — BET BUDGET FIX

What changed:
- Dedicated editable Machine BET BUDGET, no longer dependent on legacy live_trade_stake_var that historically defaulted/clamped to $10.
- Mobile amount field auto-saves while you type and has an explicit SET BET button.
- Quick $5 / $10 / $20 / $50 / $100 buttons.
- BET BUDGET supports $0.01 to $10,000.
- AUTO SIZE ON: Machine may use a fraction of the selected budget based on setup quality/re-entry/counter-scalp logic.
- AUTO SIZE OFF: Machine uses the full selected budget for an entry (subject to executable contract/count rounding).
- Non-secret Machine settings persist to /data/LECHART_RAILWAY_MACHINE_SETTINGS.json when a Railway volume is mounted.
- Kalshi credentials remain memory-only and are NOT written to that settings file.
- Entry logic, CORE HOLD SHIELD, FAST SCALP, re-entry, Coinbase/BRTI/Kalshi fusion, and live Kalshi transport are otherwise unchanged.

Deploy:
Upload/replace ALL files at the repository root and redeploy Railway.
Dockerfile launches app.py, so future version-name mismatches are avoided.
