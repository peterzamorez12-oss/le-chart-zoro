FROM python:3.12-slim
WORKDIR /app
COPY LECHART_JAMES_V23_9_22_CLOUD_PHONE_OG.py /app/james.py
ENV PYTHONUNBUFFERED=1
CMD ["python","/app/james.py"]
