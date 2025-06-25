FROM python:3.11-slim

WORKDIR /app
# Install system dependencies
RUN apt-get update && \
    apt-get install -y gcc python3-dev build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all app files including templates
COPY . .
#knfhoehvnsdmvbdsvbdclvcl v
EXPOSE 5000

CMD ["python", "app.py"]
