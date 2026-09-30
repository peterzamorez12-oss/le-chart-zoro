FROM python:3.12-slim
WORKDIR /app
RUN pip install --no-cache-dir websocket-client==1.8.0
COPY LECHART_JAMES_V23_9_22_CLOUD_PHONE_OG.py /app/james.py
ENV PYTHONUNBUFFERED=1
CMD ["python","/app/james.py"]
