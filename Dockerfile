# Dockerfile
# Use a slim Python 3.11 base image for smaller size
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies required for psutil (e.g., for compiling C extensions)
# apt-get update: Updates the package list
# apt-get install -y: Installs packages without prompting
# gcc, python3-dev, build-essential: Necessary for compiling some Python packages
# apt-get clean && rm -rf /var/lib/apt/lists/*: Cleans up cached package lists to reduce image size
RUN apt-get update && \
    apt-get install -y gcc python3-dev build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the requirements.txt file into the container
COPY requirements.txt .
# Install Python dependencies specified in requirements.txt
# --no-cache-dir: Prevents pip from storing cached wheels, further reducing image size
# -r requirements.txt: Installs packages listed in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy app.py to the working directory
COPY app.py .
# Copy the templates directory and its contents to the working directory
# Flask's render_template expects HTML files to be in a 'templates' folder by default.
COPY templates ./templates

# Expose port 5000 from the container
# This informs Docker that the container listens on this port at runtime
EXPOSE 5000

# Define the command to run when the container starts
# This executes the Flask application using Python
CMD ["python", "app.py"]

