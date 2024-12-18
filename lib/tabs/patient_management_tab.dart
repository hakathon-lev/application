import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../classes/patient_data.dart';

class PatientManagementTab extends StatefulWidget {
  const PatientManagementTab({super.key});

  @override
  State<PatientManagementTab> createState() => _PatientManagementTabState();
}

class _PatientManagementTabState extends State<PatientManagementTab> {
  late Map<String, TextEditingController> generalControllers;
  late Map<String, TextEditingController> patientControllers;
  late Map<String, TextEditingController> eventControllers;
  late Map<String, TextEditingController> caseControllers;

  final PatientData patientData = PatientData();

  @override
  void initState() {
    super.initState();
    generalControllers = _initializeControllers({
      "מס משימה": patientData.caseNumber,
      "מס ניידת": patientData.unitNumber,
      "תאריך": patientData.date,
    });
    patientControllers = _initializeControllers({
      "סוג תעודה": patientData.documentType,
      "גיל": patientData.age.toString(),
      "שם האב": patientData.fatherName,
      "מייל": patientData.email,
      "מין": patientData.gender,
      "ת. לידה": patientData.birthDate,
      "קופת חולים": patientData.healthFund,
      "כתובת": patientData.address,
      "שם מלא": patientData.fullName,
      "טלפון": patientData.phone,
      "ישוב": patientData.settlement,
    });
    eventControllers = _initializeControllers({
      "כתובת": patientData.eventAddress,
      "מקום האירוע": patientData.eventLocation,
      "עיר": patientData.city,
    });
    caseControllers = _initializeControllers({
      "המקרה שנמצא": patientData.caseFound,
      "תלונה עיקרית": patientData.mainComplaint,
      "סטטוס המטופל": patientData.patientStatus,
      "רקע רפואי": patientData.medicalBackground,
      "רגישויות": patientData.allergies,
      "תרופות קבועות": patientData.regularMedications,
    });
  }

  Map<String, TextEditingController> _initializeControllers(
      Map<String, String> data) {
    return data.map((key, value) =>
        MapEntry(key, TextEditingController(text: value.toString())));
  }

  @override
  void dispose() {
    generalControllers.values.forEach((controller) => controller.dispose());
    patientControllers.values.forEach((controller) => controller.dispose());
    eventControllers.values.forEach((controller) => controller.dispose());
    caseControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Report'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionCard(
                  title: 'מידע כללי',
                  icon: Icons.info_outline,
                  controllers: generalControllers,
                ),
                _buildSectionCard(
                  title: 'פרטי המטופל',
                  icon: Icons.person,
                  controllers: patientControllers,
                ),
                _buildSectionCard(
                  title: 'פרטי האירוע',
                  icon: Icons.location_on,
                  controllers: eventControllers,
                ),
                _buildSectionCard(
                  title: 'פירוט המקרה',
                  icon: Icons.medical_services_outlined,
                  controllers: caseControllers,
                ),
                ElevatedButton(
                  onPressed: _saveData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text('שמור נתונים'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Map<String, TextEditingController> controllers,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.orange[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1.2,
              color: Colors.orangeAccent,
            ),
            ...controllers.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextField(
                  controller: entry.value,
                  decoration: InputDecoration(
                    labelText: entry.key,
                    border: const OutlineInputBorder(),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _saveData() async {
    try {
      // Create PatientData with null-safe access
      final updatedPatientData = PatientData(
        caseNumber: generalControllers["מס משימה"]?.text ?? "N/A",
        unitNumber: generalControllers["מס ניידת"]?.text ?? "N/A",
        date: generalControllers["תאריך"]?.text ?? "N/A",
        documentType: patientControllers["סוג תעודה"]?.text ?? "N/A",
        age: int.tryParse(patientControllers["גיל"]?.text ?? "0") ?? 0,
        fatherName: patientControllers["שם האב"]?.text ?? "N/A",
        email: patientControllers["מייל"]?.text ?? "N/A",
        gender: patientControllers["מין"]?.text ?? "N/A",
        birthDate: patientControllers["ת. לידה"]?.text ?? "N/A",
        healthFund: patientControllers["קופת חולים"]?.text ?? "N/A",
        address: patientControllers["כתובת"]?.text ?? "N/A",
        fullName: patientControllers["שם מלא"]?.text ?? "N/A",
        phone: patientControllers["טלפון"]?.text ?? "N/A",
        settlement: patientControllers["ישוב"]?.text ?? "N/A",
        eventAddress: eventControllers["כתובת"]?.text ?? "N/A",
        eventLocation: eventControllers["מקום האירוע"]?.text ?? "N/A",
        city: eventControllers["עיר"]?.text ?? "N/A",
        caseFound: caseControllers["המקרה שנמצא"]?.text ?? "N/A",
        mainComplaint: caseControllers["תלונה עיקרית"]?.text ?? "N/A",
        patientStatus: caseControllers["סטטוס המטופל"]?.text ?? "N/A",
        medicalBackground: caseControllers["רקע רפואי"]?.text ?? "N/A",
        allergies: caseControllers["רגישויות"]?.text ?? "N/A",
        regularMedications: caseControllers["תרופות קבועות"]?.text ?? "N/A",
        measurements: patientData.measurements,
        proceduresPerformed: patientData.proceduresPerformed,
        medications: patientData.medications,
        evacuationType: patientData.evacuationType,
        evacuationDestination: patientData.evacuationDestination,
        hospitalName: patientData.hospitalName,
        department: patientData.department,
        receivingPersonName: patientData.receivingPersonName,
      );

      // HTTP POST request
      final url = Uri.parse("http://127.0.0.1:5000/insert_case");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updatedPatientData.toJson()),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('הנתונים נשמרו בהצלחה!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
