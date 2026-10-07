LECHART V23.9.68 RAILWAY BUILD FIX

What failed:
Your Railway screenshot shows the repo's Dockerfile still executing:
  COPY LECHART_JAMES_V23_9_67_RAILWAY_COINBASE_MACHINE.py ...
That means Railway was building with the old V23.9.67 Dockerfile while the repo had moved to the V23.9.68 brain filename.

This package fixes that two ways:
1) Dockerfile now runs a stable filename: app.py
2) It ALSO includes a V23.9.67-named compatibility copy containing the current V23.9.68 code, so even a stale old Dockerfile can still build.

Upload/replace ALL files in the repo root:
- Dockerfile
- railway.toml
- requirements.txt
- app.py
- LECHART_JAMES_V23_9_68_RAILWAY_COINBASE_MACHINE.py
- LECHART_JAMES_V23_9_67_RAILWAY_COINBASE_MACHINE.py

Then redeploy. No Machine Trader logic was changed in this repair.
