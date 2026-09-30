FROM python:3.12-slim
WORKDIR /app
RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates \
 && rm -rf /var/lib/apt/lists/* \
 && pip install --no-cache-dir "websocket-client>=1.8,<2"
COPY LECHART_JAMES_V23_9_28_MOBILE_BURN_GUARD_RPP_TRANSFER.py /app/james.py
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV LECHART_BUILD=V23.9.28-MOBILE-BURN-GUARD
CMD ["python","/app/james.py"]
