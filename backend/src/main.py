from backend.src import speech_to_text
from backend.src import send_data_to_gpt
from backend.src import compare_to_other_cases
from backend.src import gemini_api
import compare_to_db
import json
import sys
from pymongo import MongoClient



def is_button_pressed():
    #TODO: Implement button press detection
    return True  # Placeholder for actual button press detection

def main():

    client = MongoClient("mongodb+srv://robin:VkplmHD1loRCTahp@cluster0.it781.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0")
    db = client["medical_database"]
    patient_collection = db["medical_cases"]            #this i need to pass to the compare function
    users_collection = db["users"]

    our_json = {}
    
    while is_button_pressed():
        print("Speech-to-Text for Hebrew")
        audio = speech_to_text.record_audio()
        transcribed_audio = speech_to_text.transcribe_audio(audio)

        response_gemini = gemini_api.get_gimini_response(transcribed_audio)    #this is for gemini

        response = send_data_to_gpt.chat_with_gpt(transcribed_audio)    #this is for chatgpt

        json_response = json.loads(response)
        for key, value in json_response.items():                        #items is a method that returns a view object. The view object contains the key-value pairs of the dictionary, as tuples in a list.
            if key not in our_json:
                our_json[key] = value
        print(f"ChatGPT says:\n{response}")                             # just for testing
        suggestion = compare_to_db.searchSimilar(patient_collection,our_json)
    return suggestion,our_json



if __name__ == "__main__":
    main()