from flask import Flask, jsonify, render_template
import psutil

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/metrics")
def get_metrics():
    return jsonify({
        "cpu": psutil.cpu_percent(interval=1),
        "mem": psutil.virtual_memory().percent
    })

if __name__ == "__main__":
    app.run(debug=True)
