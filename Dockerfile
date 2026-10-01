FROM debian:bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive PYTHONUNBUFFERED=1 DISPLAY=:99
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-tk ca-certificates tzdata xvfb x11vnc novnc websockify \
    fonts-dejavu-core fonts-liberation \
    && rm -rf /var/lib/apt/lists/* \
    && printf '%s\n' '<!doctype html><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><script>location.replace("/vnc.html?autoconnect=true&resize=scale&reconnect=true&show_dot=true");</script>' > /usr/share/novnc/index.html
WORKDIR /app
COPY LECHART_JAMES_V23_9_33_RAILWAY_EXACT_PC_OG.py /app/
EXPOSE 8765
CMD ["bash","-lc","if [ -d /data ] && [ -w /data ]; then touch /data/chart_king_pattern_stockpile.sqlite3; ln -sfn /data/chart_king_pattern_stockpile.sqlite3 /app/chart_king_pattern_stockpile.sqlite3; fi; Xvfb :99 -screen 0 2400x900x24 -ac +extension GLX +render -noreset & sleep 0.7; x11vnc -display :99 -forever -shared -rfbport 5900 -localhost -nopw -noxdamage -quiet & websockify --web=/usr/share/novnc 0.0.0.0:${PORT:-8765} localhost:5900 & sleep 0.5; exec python3 /app/LECHART_JAMES_V23_9_33_RAILWAY_EXACT_PC_OG.py"]
