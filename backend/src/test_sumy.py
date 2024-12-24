from sumy.parsers.plaintext import PlaintextParser
from sumy.nlp.tokenizers import Tokenizer
from sumy.summarizers.lsa import LsaSummarizer as Summarizer
from sumy.nlp.stemmers import Stemmer
from sumy.utils import get_stop_words

LANGUAGE = "hebrew"
SENTENCES_COUNT = 5  # Number of sentences for the summary

def summarize_text(input_text, language=LANGUAGE, sentence_count=SENTENCES_COUNT):
    """
    Summarizes the given text using the Sumy library.

    :param input_text: The text to summarize
    :param language: The language of the text
    :param sentence_count: Number of sentences in the summary
    :return: The summary as a list of sentences
    """
    # Parse the text input
    parser = PlaintextParser.from_string(input_text, Tokenizer(language))
    stemmer = Stemmer(language)

    # Create the summarizer
    summarizer = Summarizer(stemmer)
    summarizer.stop_words = get_stop_words(language)

    # Generate the summary
    summary = [str(sentence) for sentence in summarizer(parser.document, sentence_count)]
    return summary

if __name__ == "__main__":
    # Input text to summarize
    input_text = """ """

    # Get the summary
    summary = summarize_text(input_text)

    # Print the summary
    print("Summary:")
    for sentence in summary:
        print(f"- {sentence}")