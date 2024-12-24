from pymongo import MongoClient






def searchSimilar(collection, current_case):
    try:
        query = {
            "פירוט המקרה.קוד אירוע": current_case["פירוט המקרה"]["קוד אירוע"],
            "פרטי המטופל.גיל": {"$gte": current_case["פרטי המטופל"]["גיל"] - 5, "$lte": current_case["פרטי המטופל"]["גיל"] + 5},
        }

        # Search for similar cases
        similar_cases = collection.find(query)
        cases_list = []
        for case in similar_cases:
            case['_id'] = str(case['_id'])  # Convert ObjectId to string
            cases_list.append(case)
        similar_cases=cases_list
        
        # Print results and gather treatments
        print("Similar Cases:")
        treatment_recommendations = set()
        results = []
        for case in similar_cases:
            print(case)
            results.append(case)
            treatments = case.get("טיפולים", [])
            for treatment in treatments:
                treatment_recommendations.update(treatment.get("טיפול שניתן", []))

        print("\nRecommended Treatments:")
        for treatment in treatment_recommendations:
            print(treatment)

        return {"similar_cases": results, "recommended_treatments": list(treatment_recommendations)}
    except Exception as e:
        print(f"Error during similarity search: {e}")
        return {"error": str(e)}