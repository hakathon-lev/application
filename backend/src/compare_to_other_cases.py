import json
import pymongo
from pymongo import MongoClient
from backend.src.config import json_format

def extract_required_fields(json_format):
    required_fields = []

    def extract_fields(properties, required):
        for field in required:
            if field in properties:
                if properties[field]['type'] == 'object':
                    extract_fields(properties[field]['properties'], properties[field]['required'])
                else:
                    required_fields.append(field)

    extract_fields(json_format['properties'], json_format['required'])
    return required_fields

def compare(json_response):
    # Connect to the MongoDB database
    client = MongoClient('mongodb://localhost:27017/')
    db = client['paramedics_db']
    collection = db['cases']

    # Extract the required information from the json_response
    required_fields = extract_required_fields(json_format)
    important_info = {field: json_response[field] for field in required_fields if field in json_response}

    # Query the database for similar cases
    query = {"required": important_info}
    similar_cases = collection.find(query)

    # Compare the extracted data with the similar cases
    advice_list = []
    for case in similar_cases:
        # Collect the treatment advice from similar cases
        advice_list.append(case.get('טיפולים', []))

    # Close the database connection
    client.close()

    # Return the collected advice
    return advice_list

# for testing not actually important
if __name__ == "__main__":
    pass