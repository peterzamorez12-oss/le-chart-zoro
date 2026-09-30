FROM python:3.12-slim
WORKDIR /app
RUN pip install --no-cache-dir websocket-client==1.8.0
COPY LECHART_JAMES_V23_9_25_BEHAVIOR_MEMORY_REPLAY_CLOUD_OG.py /app/james.py
ENV PYTHONUNBUFFERED=1
EXPOSE 8080
CMD ["python","/app/james.py"]
