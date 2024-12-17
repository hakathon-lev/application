class PatientData {
  final String caseNumber;
  final String unitNumber;
  final String date;
  final Map<String, String> patientDetails;
  final Map<String, String> eventDetails;
  final Map<String, String> caseDetails;
  final List<Map<String, dynamic>> metrics;
  final List<Map<String, dynamic>> treatments;
  final List<Map<String, dynamic>> medications;
  final Map<String, String> evacuation;

  PatientData({
    required this.caseNumber,
    required this.unitNumber,
    required this.date,
    required this.patientDetails,
    required this.eventDetails,
    required this.caseDetails,
    required this.metrics,
    required this.treatments,
    required this.medications,
    required this.evacuation,
  });

  Map<String, dynamic> toJson() {
    return {
      "מס משימה": caseNumber,
      "מס ניידת": unitNumber,
      "תאריך": date,
      "פרטי המטופל": patientDetails,
      "פרטי האירוע": eventDetails,
      "פירוט המקרה": caseDetails,
      "מדדים": metrics,
      "טיפולים": treatments,
      "טיפול תרופתי": medications,
      "פינוי": evacuation,
    };
  }
}
