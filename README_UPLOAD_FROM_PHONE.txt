V23.9.34 RAILWAY EXACT PC OG — DEPLOYMENT FIX

Upload/replace these FOUR files at the ROOT of the GitHub repo:
1) LECHART_JAMES_V23_9_34_RAILWAY_EXACT_PC_OG.py
2) railway_desktop_launcher.py
3) Dockerfile
4) railway.toml

Delete/rename the previous V23.9.33 Python file if you want to keep the repo clean; it is not used by this Dockerfile.
Keep the existing Railway /data volume and Variables.

This is NOT the mobile cockpit. It launches the actual Tkinter PC Zoro dashboard in Xvfb and exposes that desktop through noVNC.
The strategy/UI source is the same V23.9.33 exact-PC port; V23.9.34 changes the Railway runtime wrapper and release label only.

Expected deployment log milestones:
[RAILWAY-DESKTOP] starting Xvfb
[RAILWAY-DESKTOP] starting x11vnc
[RAILWAY-DESKTOP] starting noVNC/websockify
[RAILWAY-DESKTOP] public desktop listener READY
LOADED V23.9.34 ...
UI ready in ...s
[RAILWAY-DESKTOP] LeChart James Zoro desktop survived startup; deployment is live
