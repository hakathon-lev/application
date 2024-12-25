import os
import google.generativeai as genai
import config
# from dotenv import find_dotenv, load_dotenv
# env = find_dotenv()
# load_dotenv(dotenv_path=env)


def get_gimini_response(text):
    genai.configure(api_key=os.environ["GEMINI_API_KEY"])

    # Create the model
    generation_config = {
    "temperature": 1,
    "top_p": 0.95,
    "top_k": 40,
    "max_output_tokens": 8192,
    "response_mime_type": "text/plain",
    }

    model = genai.GenerativeModel(
    model_name="gemini-2.0-flash-exp",
    generation_config=generation_config,
    )

    chat_session = model.start_chat(
    history=[
    ]
    )

    response = chat_session.send_message(config.GEMINI_REQUIREMENTS + text)

    print(response.text)


#just for testing
if __name__ == "__main__":
    get_gimini_response("what is the meaning of life?")