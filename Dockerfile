FROM python:3.9-slim-buster

WORKDIR /app

# Install system dependencies required for building packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    python3-dev \
    libgomp1 && \
    rm -rf /var/lib/apt/lists/*

COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

CMD ["python3", "flask_api/main.py"]
