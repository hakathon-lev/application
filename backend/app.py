from flask import Flask, jsonify, request
from flask_cors import CORS
import os
import speech_recognition as sr
import numpy as np
import soundfile as sf
import io

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
        
        log_entry = (
            f"Case Location: {data.get('caseLocation', 'N/A')}\n"
            f"Exit Point: {data.get('exitPoint', 'N/A')}\n"
            f"Case Type: {data.get('caseType', 'N/A')}\n"
            f"Timestamp: {data.get('timestamp', 'N/A')}\n"
            f"Actions: {data.get('actions', 'N/A')}\n"
            "--------------------------\n"
        )

        # Ensure logs directory and write to the file
        log_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "logs")
        os.makedirs(log_dir, exist_ok=True)
        log_file_path = os.path.join(log_dir, "queries.txt")

        with open(log_file_path, "a", encoding="utf-8") as file:
            file.write(log_entry)

        return jsonify({"message": "Data logged successfully!", "details": data}), 200

    except Exception as e:
        print(f"Error during logging to file: {e}")
        return jsonify({"error": f"Internal server error: {str(e)}"}), 500

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
