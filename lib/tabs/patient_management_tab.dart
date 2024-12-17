import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  final PatientData patientData = PatientData(
    caseNumber: '12345',
    unitNumber: '56789',
    date: '2024-12-17',
    patientDetails: {"שם": "יוסי", "ת.ז": "123456789"},
    eventDetails: {"מיקום": "תל אביב", "זמן": "12:00"},
    caseDetails: {"תיאור": "כאב חזה חריף"},
    metrics: [],
    treatments: [],
    medications: [],
    evacuation: {"סוג פינוי": "אמבולנס"},
  );

  @override
  void initState() {
    super.initState();
    generalControllers = _initializeControllers({
      "מס משימה": patientData.caseNumber,
      "מס ניידת": patientData.unitNumber,
      "תאריך": patientData.date,
    });
    patientControllers = _initializeControllers(patientData.patientDetails);
    eventControllers = _initializeControllers(patientData.eventDetails);
    caseControllers = _initializeControllers(patientData.caseDetails);
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
        title: const Text('Patient Management'),
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
        patientDetails:
            patientControllers.map((key, value) => MapEntry(key, value.text)),
        eventDetails:
            eventControllers.map((key, value) => MapEntry(key, value.text)),
        caseDetails:
            caseControllers.map((key, value) => MapEntry(key, value.text)),
        metrics: patientData.metrics,
        treatments: patientData.treatments,
        medications: patientData.medications,
        evacuation: patientData.evacuation,
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
