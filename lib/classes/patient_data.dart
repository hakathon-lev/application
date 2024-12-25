// Class for the patient form
class PatientData {
  final String caseNumber;
  final String unitNumber;
  final String date;

  // Patient Details
  final String documentType;
  final String age;
  final String fatherName;
  final String email;
  final String gender;
  final String birthDate;
  final String healthFund;
  final String address;
  final String fullName;
  final String phone;
  final String settlement;
  final String bloodType; // New field

  // Event Details
  final String eventAddress;
  final String eventLocation;
  final String city;
  final String incidentTime; // New field

  // Case Details
  final String caseFound;
  final String mainComplaint;
  final String patientStatus;
  final String medicalBackground;
  final String allergies;
  final String regularMedications;
  final String injurySeverity; // New field

  // Measurements
  final List<Map<String, String>> measurements;

  // Procedures Performed
  final List<Map<String, String>> proceduresPerformed;

  // Medications
  final List<Map<String, String>> medications;

  // Evacuation
  final String evacuationType;
  final String evacuationDestination;
  final String hospitalName;
  final String department;
  final String receivingPersonName;

  PatientData({
    this.caseNumber = '',
    this.unitNumber = '',
    this.date = '',

    // Patient Details
    this.documentType = '',
    this.age = '',
    this.fatherName = '',
    this.email = '',
    this.gender = '',
    this.birthDate = '',
    this.healthFund = '',
    this.address = '',
    this.fullName = '',
    this.phone = '',
    this.settlement = '',
    this.bloodType = '',

    // Event Details
    this.eventAddress = '',
    this.eventLocation = '',
    this.city = '',
    this.incidentTime = '',

    // Case Details
    this.caseFound = '',
    this.mainComplaint = '',
    this.patientStatus = '',
    this.medicalBackground = '',
    this.allergies = '',
    this.regularMedications = '',
    this.injurySeverity = '',

    // Measurements
    this.measurements = const [],

    // Procedures Performed
    this.proceduresPerformed = const [],

    // Medications
    this.medications = const [],

    // Evacuation
    this.evacuationType = '',
    this.evacuationDestination = '',
    this.hospitalName = '',
    this.department = '',
    this.receivingPersonName = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "מס משימה": caseNumber,
      "מס' ניידת": unitNumber,
      "date": date,
      "פרטי המטופל": {
        "סוג תעודה": documentType,
        "גיל": age,
        "שם האב": fatherName,
        "מייל": email,
        "מין": gender,
        "ת. לידה": birthDate,
        "קופת חולים": healthFund,
        "כתובת": address,
        "שם מלא": fullName,
        "טלפון": phone,
        "ישוב": settlement,
        "סוג דם": bloodType, // New field
      },
      "פרטי האירוע": {
        "כתובת": eventAddress,
        "מקום האירוע": eventLocation,
        "עיר": city,
        "שעת האירוע": incidentTime, // New field
      },
      "פירוט המקרה": {
        "המקרה שנמצא": caseFound,
        "תלונה עיקרית": mainComplaint,
        "סטטוס המטופל": patientStatus,
        "רקע רפואי": medicalBackground,
        "רגישויות": allergies,
        "תרופות קבועות": regularMedications,
        "חומרת הפציעה": injurySeverity, // New field
      },
      "מדדים": measurements,
      "טיפול שניתן": proceduresPerformed,
      "טיפול תרופתי": medications,
      "פינוי": {
        "אופן הפינוי": evacuationType,
        "יעד הפינוי": evacuationDestination,
        "שם בית החולים": hospitalName,
        "מחלקה": department,
        "שם המקבל ביעד הפינוי": receivingPersonName,
      },
    };
  }
}
