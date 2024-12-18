class PatientData {
  final String caseNumber;
  final String unitNumber;
  final String date;

  // Patient Details
  final String documentType;
  final int age;
  final String fatherName;
  final String email;
  final String gender;
  final String birthDate;
  final String healthFund;
  final String address;
  final String fullName;
  final String phone;
  final String settlement;

  // Event Details
  final String eventAddress;
  final String eventLocation;
  final String city;

  // Case Details
  final String caseFound;
  final String mainComplaint;
  final String patientStatus;
  final String medicalBackground;
  final String allergies;
  final String regularMedications;

  // Measurements
  final List<Map<String, dynamic>> measurements;

  // Procedures Performed
  final List<Map<String, dynamic>> proceduresPerformed;

  // Medications
  final List<Map<String, dynamic>> medications;

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
    this.age = 0,
    this.fatherName = '',
    this.email = '',
    this.gender = '',
    this.birthDate = '',
    this.healthFund = '',
    this.address = '',
    this.fullName = '',
    this.phone = '',
    this.settlement = '',

    // Event Details
    this.eventAddress = '',
    this.eventLocation = '',
    this.city = '',

    // Case Details
    this.caseFound = '',
    this.mainComplaint = '',
    this.patientStatus = '',
    this.medicalBackground = '',
    this.allergies = '',
    this.regularMedications = '',

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
      },
      "פרטי האירוע": {
        "כתובת": eventAddress,
        "מקום האירוע": eventLocation,
        "עיר": city,
      },
      "פירוט המקרה": {
        "המקרה שנמצא": caseFound,
        "תלונה עיקרית": mainComplaint,
        "סטטוס המטופל": patientStatus,
        "רקע רפואי": medicalBackground,
        "רגישויות": allergies,
        "תרופות קבועות": regularMedications,
      },
      "measurments": measurements,
      "procedures_performed": proceduresPerformed,
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
