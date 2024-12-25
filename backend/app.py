import os
import base64
import json
import numpy as np
import soundfile as sf
from flask import Flask, jsonify, request
from flask_cors import CORS
from datetime import datetime
from pymongo import MongoClient
import speech_recognition as sr


app = Flask(__name__)
CORS(app)

# Ensure the directory for logs exists
os.makedirs("logs", exist_ok=True)

@app.route('/analyze', methods=['POST'])
def analyze():
    try:
        data = request.json

        if not data:
            return jsonify({"error": "No JSON data provided"}), 400

        print("Received data:", data)

        # Ensure logs directory and log file exist
        log_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "logs")
        os.makedirs(log_dir, exist_ok=True)
        log_file_path = os.path.join(log_dir, "queries.json")

        # Read the existing log file or create a new one
        if os.path.exists(log_file_path):
            with open(log_file_path, "r", encoding="utf-8") as file:
                try:
                    logs = json.load(file)
                except json.JSONDecodeError:
                    logs = []
        else:
            logs = []

        # Add the new log entry
        logs.append({
            "caseLocation": data.get("caseLocation", "N/A"),
            "exitPoint": data.get("exitPoint", "N/A"),
            "caseType": data.get("caseType", "N/A"),
            "timestamp": data.get("timestamp", "N/A"),
            "actions": data.get("actions", "N/A")
        })

        # Write back to the JSON file
        with open(log_file_path, "w", encoding="utf-8") as file:
            json.dump(logs, file, indent=4, ensure_ascii=False)

        return jsonify({"message": "Data logged successfully!", "details": data}), 200

    except Exception as e:
        print(f"Error during logging to file: {e}")
        return jsonify({"error": f"Internal server error: {str(e)}"}), 500
    

client = MongoClient("mongodb+srv://robin:VkplmHD1loRCTahp@cluster0.it781.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0")
db = client["medical_database"]
patient_collection = db["cases"]

def generate_json(data):
    case_metadata = {
        "מס משימה": data.get("מס משימה", "5678"),
        "מס ניידת": data.get("מס ניידת", "1234"),
        "תאריך": data.get("תאריך", "23/10/2024"),
        "פרטי המטופל": data.get("פרטי המטופל", {}),
        "פרטי האירוע": data.get("פרטי האירוע", {}),
        "פירוט המקרה": data.get("פירוט המקרה", {}),
        "מדדים": data.get("מדדים", []),
        "טיפולים": data.get("טיפולים", []),
        "טיפול תרופתי": data.get("טיפול תרופתי", []),
        "פינוי": data.get("פינוי", {}),
    }
    return case_metadata

@app.route('/insert_case', methods=['POST'])
def insert_case():
    try:
        data = request.json
        case_metadata = generate_json(data)
        result = patient_collection.insert_one(case_metadata)
        return jsonify({"message": "Case inserted successfully", "id": str(result.inserted_id)})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    

@app.route('/transcribe', methods=['POST'])
def transcribe():
    if 'file' not in request.files:
        return jsonify({'error': 'No file provided'}), 400

    file = request.files['file']
    audio_data, samplerate = sf.read(file)
    recognizer = sr.Recognizer()

    # Convert numpy array to raw PCM data
    audio_data = audio_data.astype(np.int16).tobytes()
    sample_width = np.dtype(np.int16).itemsize

    audio_source = sr.AudioData(audio_data, samplerate, sample_width)
    try:
        text = recognizer.recognize_google(audio_source, language="he-IL")
        return jsonify({'transcript': text})
    except sr.UnknownValueError:
        return jsonify({'error': 'Could not understand the audio'}), 400
    except sr.RequestError as e:
        return jsonify({'error': f'API error: {e}'}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
