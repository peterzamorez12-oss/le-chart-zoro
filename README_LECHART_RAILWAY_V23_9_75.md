# Le Chart James — Railway/Mobile V23.9.75 Endgame Research

## Base and scope

Built from the latest **available saved Railway/mobile code**, V23.9.69, with its core unchanged. Adds a **read-only** `ZONE / FLIP / ENDGAME` research card and `/api/endgame75` JSON endpoint. **This release does not deploy itself** and has not been validated against live market feeds or actual Railway uptime.

**Provider authority:** Coinbase BTC-USD is the only external spot analysis feed in the cloud version. Kalshi market BBO/ticker and official BRTI are used for comparison and settlement reference. **Native Bookmap feeds, platform heatmaps, and order-book depth are not available in this build.** No new data-provider subscription is required by the new code.

## Added

- Nearest pivot-based **support/resistance zone**, heuristic break-pressure vs rejection-pressure and compression. Confirmed closed 1-minute pivots only.
- **Pattern development** on closed 15-second Coinbase tick candles (if enough history): double/triple top/bottom, head/shoulders, bull/bear flags, triangles, wedges and tentative cup/handle. The pattern status is forming/breakout observed, not a probability of success.
- Coinbase **executed buy/sell trade delta** comparison. Without Coinbase Level2 book, the panel deliberately does **not** claim confirmed absorption or depth walls. This is a partial adaptation of the Bookmap-native V23.9.74 order-flow analysis.
- Kalshi **BRTI reference** with separate freshness check, **first-touch** strike model at 30/60/120/300 seconds (bounded by remaining time), and **final-minute settlement-average Gaussian model**. Last-minute estimates stay `WAIT` without a valid official accumulating average. Model numbers are uncalibrated, *not* proven chances of winning.
- Coinbase-vs-BRTI **basis** and feed-age health warnings. Closed bars are reconstructed in source-timestamp order for the **new research pane** only. Older Railway machine/candle acquisition logic remains unchanged; this is not a blanket fix for every pre-existing phantom-candle issue.
- **Original-first-lock record** per 15-minute round (frozen if newly observed and timestamp-valid), an endgame disagreement flag, time-stamped ~10-second forecast ledger, and bounded **official Kalshi result verification** after a round rolls over. A result is never inferred from Coinbase's last trade. Results with ambiguous YES-side semantics remain pending.
- Mobile research card and **Export forecast JSON**. Existing V23.9.69 Machine/Bet Budget/auto-order controls remain untouched. These new readouts **do not direct trades**.

## Important limitations

- This is a **partial mobile adaptation** of the Bookmap V23.9.74 research features, not a native Bookmap port. Bookmap-only depth/absorption, the complete desktop Shadow Machine simulator, and desktop chart overlays were not ported. The new ledger enables frozen-first-lock research and eventual external replay comparison.
- The pre-existing Railway base **still includes live automatic order features** if explicitly armed/credentialed. The *new* research endpoint is read-only, but this is **not an entirely paper-trading app**. Do not experiment with live funds. Test with auto trading disarmed first.
- The spot-price source is not the BRTI basket. A price difference is not inherently a timing advantage. Abnormal candle behavior in the inherited primary price renderer must be addressed independently.
- Cloud disk writes persist across redeploys **only if** your existing Railway persistent volume is correctly mounted. Research JSONL ledgers use `RAILWAY_VOLUME_MOUNT_PATH`, `JAMES_DATA_DIR`, or `/data` when writable, otherwise the current working directory.
- Model outputs have **not** been empirically calibrated, and no improvement to historical or live trading success is claimed.

## Deploy

1. **Back up** the current Railway service/repo and environment variables before deployment.
2. Extract `LECHART_RAILWAY_V23_9_75_ENDGAME_MOBILE_DEPLOY.zip` at the repository root. It includes `app.py`, `Dockerfile`, `requirements.txt`, and `railway.toml` from the last saved Railway deploy package, with `app.py` replaced by this build.
3. Redeploy the same Railway service. Verify the page header reads `RAILWAY MACHINE 23.9.75` and that you see `ZONE / FLIP / ENDGAME • RESEARCH ONLY`.
4. Keep Machine live auto trading **disarmed** while validating the new panel. Wait for closed candles and official BRTI. Check `GET /api/endgame75` for `build: 23.9.75` and `health` warnings.
5. Confirm exact current-round Kalshi strike/ticker; compare the first-lock ledger to confirmed settled Kalshi results, and measure data quality before relying on the new analyses.

## Checks performed offline

- Python compilation and import in the test environment.
- Mobile card insertion and standalone + full-page JavaScript syntax checks.
- Synthetic BRTI/spot forecast test, stale-reference WAIT behavior, original-first-lock freeze, and read-only output checks.
- Original Railway V23.9.69 source was preserved byte-for-byte up to its final boot block; the new analytics are appended before the boot block.

**Not performed:** actual Railway deployment, real authenticated Kalshi connection, real Coinbase WS resilience/latency testing, backtesting calibration or validation of live-order execution.
