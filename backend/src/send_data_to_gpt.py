import openai
import backend.src.config as config

# Replace 'YOUR_API_KEY' with your actual OpenAI API key
openai.api_key = "YOUR_API_KEY"

def chat_with_gpt(prompt, model="gpt-4"):
    try:
        chatgpt_requirements_for_answer=config.CHATGPT_REQUIREMENTS
        response = openai.ChatCompletion.create(
            model=model,
            messages=[
                {"role": "system", "content": chatgpt_requirements_for_answer},
                {"role": "user", "content": prompt}
            ]
        )
        return response['choices'][0]['message']['content'].strip()
    except Exception as e:
        return f"An error occurred: {e}"

# Example usage
if __name__ == "__main__":
    user_input = input("Enter your message for ChatGPT: ")
    response = chat_with_gpt(user_input)
    print(f"ChatGPT says:\n{response}")
