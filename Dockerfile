FROM debian:bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    DISPLAY=:99 \
    HOME=/app/home \
    NOVNC_WEB=/usr/share/novnc

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-tk python3-websocket python3-cryptography \
    ca-certificates tzdata \
    xvfb x11vnc novnc websockify \
    fonts-dejavu-core fonts-liberation \
    && rm -rf /var/lib/apt/lists/* \
    && test -f /usr/share/novnc/vnc.html

WORKDIR /app
COPY LECHART_JAMES_V23_9_34_RAILWAY_EXACT_PC_OG.py /app/
COPY railway_desktop_launcher.py /app/
RUN mkdir -p /app/home/Downloads \
    && chmod +x /app/railway_desktop_launcher.py \
    && python3 -m py_compile /app/LECHART_JAMES_V23_9_34_RAILWAY_EXACT_PC_OG.py /app/railway_desktop_launcher.py

EXPOSE 8765
CMD ["python3","/app/railway_desktop_launcher.py"]
