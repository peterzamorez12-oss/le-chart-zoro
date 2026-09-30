FROM python:3.12-slim
WORKDIR /app
RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates \
 && rm -rf /var/lib/apt/lists/*
COPY LECHART_JAMES_V23_9_22_6_COINBASE_CLOUD_OG.py /app/james.py
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV LECHART_BUILD=V23.9.22.6-COINBASE-OG
CMD ["python","/app/james.py"]
