# app.py
from flask import Flask, jsonify, render_template
import psutil

app = Flask(__name__)

# Route to serve the main HTML page
@app.route("/")
def index():
    # Renders the index.html file located in the 'templates' directory
    # (Flask expects templates to be in a 'templates' folder by default)
    return render_template("index.html")

# Route to provide system metrics as JSON
@app.route("/metrics")
def get_metrics():
    # Get current CPU usage over a 1-second interval
    # This call blocks for 1 second to calculate the percentage
    cpu_percent = psutil.cpu_percent(interval=1)
    # Get current virtual memory (RAM) usage percentage
    mem_percent = psutil.virtual_memory().percent

    # IMPORTANT DEBUGGING LINE:
    # Print the fetched metrics to the Docker container's logs.
    # This helps verify what values psutil is returning.
    print(f"DEBUG: CPU: {cpu_percent}%, Memory: {mem_percent}%")

    # Return the metrics as a JSON response
    return jsonify({
        "cpu": cpu_percent,
        "mem": mem_percent
    })

# Entry point for the Flask application
if __name__ == "__main__":
    # Run the Flask app on all available network interfaces (0.0.0.0)
    # and listen on port 5000.
    # This makes the app accessible from outside the container.
    app.run(host="0.0.0.0", port=5000)
