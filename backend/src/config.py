
hebrew_keywords = [
    "מס משימה",
    "מס ניידת",
    "תאריך",
    "סוג תעודה",
    "גיל",
    "שם האב",
    "מייל",
    "מין",
    "תאריך לידה",
    "קופת חולים",
    "כתובת",
    "שם מלא",
    "טלפון",
    "ישוב",
    "מקום האירוע",
    "עיר",
    "המקרה שנמצא",
    "תלונה עיקרית",
    "סטטוס המטופל",
    "רקע רפואי",
    "רגישויות",
    "תרופות קבועות"
]

json_format ={
    "type": "object",
    "required": ["מס משימה", "מס ניידת", "תאריך", "פרטי המטופל", "פרטי האירוע", "פירוט המקרה", "מדדים", "טיפולים", "טיפול תרופתי", "פינוי"],
    "properties": {
        "מס משימה": {"type": "string"},
        "מס ניידת": {"type": "string"},
        "תאריך": {"type": "string"},
        "פרטי המטופל": {
        "type": "object",
        "required": ["סוג תעודה", "גיל", "מין"],
        "properties": {
            "סוג תעודה": {"type": "string"},
            "גיל": {"type": "integer"},
            "שם האב": {"type": "string"},
            "מייל": {"type": "string"},
            "מין": {"type": "string"},
            "ת. לידה": {"type": "string"},
            "קופת חולים": {"type": "string"},
            "כתובת": {"type": "string"},
            "שם מלא": {"type": "string"},
            "טלפון": {"type": "string"},
            "ישוב": {"type": "string"}
        }
        },
        "פרטי האירוע": {
        "type": "object",
        "required": ["כתובת", "מקום האירוע", "עיר"],
        "properties": {
            "כתובת": {"type": "string"},
            "מקום האירוע": {"type": "string"},
            "עיר": {"type": "string"}
        }
        },
        "פירוט המקרה": {
        "type": "object",
        "required": ["המקרה שנמצא", "תלונה עיקרית", "אנמנזה", "סטטוס המטופל"],
        "properties": {
            "המקרה שנמצא": {"type": "string"},
            "תלונה עיקרית": {"type": "string"},
            "אנמנזה": {"type": "string"},
            "סטטוס המטופל": {"type": "string"},
            "רקע רפואי": {"type": "string"},
            "רגישויות": {"type": "string"},
            "תרופות קבועות": {"type": "string"}
        }
        },
        "מדדים": {
        "type": "array",
        "items": {
            "type": "object",
            "required": ["זמן בדיקה", "הכרה", "נשימה"],
            "properties": {
            "זמן בדיקה": { "type": "string" },
                "הכרה": { "type": "string" },
                "נשימה": { "type": "string" },
                "קצב נשימה": { "type": "string" },
                "דופק": { "type": "string" },
                "דופק לדקה": { "type": "string" },
                "מצב העור": { "type": "string" },
                "סרגל כאב": { "type": "string" },
                "האזנה": { "type": "string" },
                "ריאה ימין": { "type": "string" },
                "ריאה שמאל": { "type": "string" },
                "ETCO2": { "type": "string" },
                "קצב לב": { "type": "string" },
                "אישונים": { "type": "string" },
                "ציון גלזגו": { "type": "string" }       
                }
            }
        }
        },
        "טיפולים": {
        "type": "array",
        "items": {
            "type": "object",
            "required": ["זמן", "טיפול שניתן"],
            "properties": {
            "זמן": {"type": "string"},
            "טיפול שניתן": {"type": "array", "items": {"type": "string"}}
            }
        }
        },
        "טיפול תרופתי": {
        "type": "array",
        "items": {
            "type": "object",
            "required": ["זמן", "תרופה"],
            "properties": {
            "זמן": {"type": "string"},
            "תרופה": {"type": "array", "items": {"type": "string"}}
            }
        }
        },
        "פינוי": {
        "type": "object",
        "required": ["אופן הפינוי", "יעד הפינוי", "שם בית החולים"],
        "properties": {
            "אופן הפינוי": {"type": "string"},
            "יעד הפינוי": {"type": "string"},
            "שם בית החולים": {"type": "string"},
            "מחלקה": {"type": "string"},
            "שם המקבל ביעד הפינוי": {"type": "string"}
        }
        }
    }

CHATGPT_REQUIREMENTS = f"""
You are a text processor.I will provide you with a Hebrew text and a list of hebrew keywords.
Your task is to extract the values corresponding to these keywords and return a valid JSON object.
hebrew keywords:
{hebrew_keywords}
fill this json object with the values you find in the user input text:
{json_format}
"""


GEMINI_REQUIREMENTS = f"""
You are a text processor.I will provide you with a Hebrew text and a list of hebrew keywords.
Your task is to extract the values corresponding to these keywords and return a valid JSON object.
hebrew keywords:
{hebrew_keywords}
fill this json object with the values you find in the user input text:
{json_format}

text:
"""