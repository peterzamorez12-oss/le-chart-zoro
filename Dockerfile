FROM python:3.12-slim
WORKDIR /app
RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates \
 && rm -rf /var/lib/apt/lists/* \
 && pip install --no-cache-dir "websocket-client>=1.8,<2"
COPY LECHART_JAMES_V23_9_32_RAILWAY_COINBASE_OG.py /app/james.py
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV LECHART_BUILD=V23.9.32-RAILWAY-COINBASE-OG
CMD ["python","/app/james.py"]
