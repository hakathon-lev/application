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
  late List<List<TextEditingController>> measurementsControllers;
  late List<List<TextEditingController>> proceduresControllers;
  late List<List<TextEditingController>> medicationsControllers;
  late Map<String, TextEditingController> evacuationControllers;

  final PatientData patientData = PatientData();

  @override
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
      "גיל": patientData.age,
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

    // Initialize 2D empty lists for measurementsControllers, proceduresControllers, and medicationsControllers
    measurementsControllers = List.generate(
      7,
      (_) => [TextEditingController(), TextEditingController()],
    );

    proceduresControllers = List.generate(
      7,
      (_) => [TextEditingController(), TextEditingController()],
    );

    medicationsControllers = List.generate(
      7,
      (_) => [TextEditingController(), TextEditingController()],
    );

    evacuationControllers = _initializeControllers({
      "אופן הפינוי": "",
      "יעד הפינוי": "",
      "שם בית החולים": "",
      "מחלקה": "",
      "שם המקבל ביעד הפינוי": "",
    });
  }

  Map<String, TextEditingController> _initializeControllers(
      Map<String, String> data) {
    return data.map((key, value) =>
        MapEntry(key, TextEditingController(text: value.toString())));
  }

  @override
  void dispose() {
    for (var controller in generalControllers.values) {
      controller.dispose();
    }
    for (var controller in patientControllers.values) {
      controller.dispose();
    }
    for (var controller in eventControllers.values) {
      controller.dispose();
    }
    for (var controller in caseControllers.values) {
      controller.dispose();
    }
    // Dispose controllers in 2D lists
    for (var row in measurementsControllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    for (var row in proceduresControllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    for (var row in medicationsControllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    for (var controller in evacuationControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // Add new cards to the build method
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
                buildTable('מדדים', measurementsControllers, 'זמן בדיקה',
                    'מדד שנלקח'), // Updated to use buildTable
                buildTable('טיפולים', proceduresControllers, 'זמן טיפול',
                    'טיפול שניתן'), // Updated to use buildTable
                buildTable('טיפול תרופתי', medicationsControllers, 'זמן תרופה',
                    'תרופה שניתנה'), // Updated to use buildTable
                _buildSectionCard(
                  title: 'פינוי',
                  icon: Icons.directions_bus,
                  controllers: evacuationControllers,
                ),
                ElevatedButton(
                  onPressed: _saveData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text('שמור נתונים'),
                ),
                ElevatedButton(
                  onPressed: _loadDataFromServer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('טען נתונים משרת'),
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
                  textAlign: TextAlign
                      .right, // Aligns the text inside the field to the right
                  decoration: InputDecoration(
                    labelText: entry.key,
                    border: const OutlineInputBorder(),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildTable(String title, List<List<TextEditingController>> controllers,
      String key, String value) {
    return Card(
      color: Colors.orange[50],
      margin: const EdgeInsets.all(8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
            const Divider(
              thickness: 1.2,
              color: Colors.orangeAccent,
            ),
            const SizedBox(height: 8),
            Table(
              border: TableBorder.all(color: Colors.grey),
              columnWidths: const {
                0: FractionColumnWidth(0.3),
                1: FractionColumnWidth(0.7),
              },
              children: [
                // Table headers
                TableRow(
                  decoration: BoxDecoration(color: Colors.orange[50]),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(key,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(value,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                // Table rows
                ...controllers.asMap().entries.map(
                  (entry) {
                    List<TextEditingController> rowControllers = entry.value;

                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            controller: rowControllers[0],
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            controller: rowControllers[1],
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _loadDataFromServer() async {
    try {
      final url =
          Uri.parse("https://your-remote-server.com/api/get_patient_data");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        setState(() {
          generalControllers.forEach((key, controller) {
            controller.text = jsonData[key] ?? controller.text;
          });
          patientControllers.forEach((key, controller) {
            controller.text = jsonData[key] ?? controller.text;
          });
          eventControllers.forEach((key, controller) {
            controller.text = jsonData[key] ?? controller.text;
          });
          caseControllers.forEach((key, controller) {
            controller.text = jsonData[key] ?? controller.text;
          });

          // Update for 2D lists
          measurementsControllers.asMap().forEach((index, controllers) {
            controllers.asMap().forEach((innerIndex, controller) {
              final key = "measurements_${index}_$innerIndex";
              controller.text = jsonData[key] ?? controller.text;
            });
          });
          proceduresControllers.asMap().forEach((index, controllers) {
            controllers.asMap().forEach((innerIndex, controller) {
              final key = "procedures_${index}_$innerIndex";
              controller.text = jsonData[key] ?? controller.text;
            });
          });
          medicationsControllers.asMap().forEach((index, controllers) {
            controllers.asMap().forEach((innerIndex, controller) {
              final key = "medications_${index}_$innerIndex";
              controller.text = jsonData[key] ?? controller.text;
            });
          });

          evacuationControllers.forEach((key, controller) {
            controller.text = jsonData[key] ?? controller.text;
          });
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('נתונים נטענו בהצלחה!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server Error: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    }
  }

  void _saveData() async {
    try {
      // Create PatientData with null-safe access
      final updatedPatientData = PatientData(
        caseNumber: generalControllers["מס משימה"]?.text ?? "N/A",
        unitNumber: generalControllers["מס ניידת"]?.text ?? "N/A",
        date: generalControllers["תאריך"]?.text ?? "N/A",
        documentType: patientControllers["סוג תעודה"]?.text ?? "N/A",
        age: patientControllers["גיל"]?.text ?? "0",
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
        evacuationType: evacuationControllers["אופן הפינוי"]?.text ?? "N/A",
        evacuationDestination:
            evacuationControllers["יעד הפינוי"]?.text ?? "N/A",
        hospitalName: evacuationControllers["שם בית החולים"]?.text ?? "N/A",
        department: evacuationControllers["מחלקה"]?.text ?? "N/A",
        receivingPersonName:
            evacuationControllers["שם המקבל ביעד הפינוי"]?.text ?? "N/A",
      );

      // Update the server URL to the remote endpoint
      final url = Uri.parse("https://your-remote-server.com/api/insert_case");

      // HTTP POST request
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          // Add authentication headers if needed
          // "Authorization": "Bearer your_token"
        },
        body: jsonEncode(updatedPatientData.toJson()),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('הנתונים נשמרו בהצלחה!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('שגיאת שרת: ${response.statusCode} - ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('שגיאה: $e')),
      );
    }
  }

  // void _loadJsonData(String jsonString) {
  //   try {
  //     final jsonData = jsonDecode(jsonString);

  //     // Assuming jsonData matches PatientData structure
  //     final loadedPatientData = PatientData(
  //       caseNumber: jsonData['caseNumber'] ?? "N/A",
  //       unitNumber: jsonData['unitNumber'] ?? "N/A",
  //       date: jsonData['date'] ?? "N/A",
  //       documentType: jsonData['documentType'] ?? "N/A",
  //       age: jsonData['age'] ?? 0,
  //       fatherName: jsonData['fatherName'] ?? "N/A",
  //       email: jsonData['email'] ?? "N/A",
  //       gender: jsonData['gender'] ?? "N/A",
  //       birthDate: jsonData['birthDate'] ?? "N/A",
  //       healthFund: jsonData['healthFund'] ?? "N/A",
  //       address: jsonData['address'] ?? "N/A",
  //       fullName: jsonData['fullName'] ?? "N/A",
  //       phone: jsonData['phone'] ?? "N/A",
  //       settlement: jsonData['settlement'] ?? "N/A",
  //       eventAddress: jsonData['eventAddress'] ?? "N/A",
  //       eventLocation: jsonData['eventLocation'] ?? "N/A",
  //       city: jsonData['city'] ?? "N/A",
  //       caseFound: jsonData['caseFound'] ?? "N/A",
  //       mainComplaint: jsonData['mainComplaint'] ?? "N/A",
  //       patientStatus: jsonData['patientStatus'] ?? "N/A",
  //       medicalBackground: jsonData['medicalBackground'] ?? "N/A",
  //       allergies: jsonData['allergies'] ?? "N/A",
  //       regularMedications: jsonData['regularMedications'] ?? "N/A",
  //       measurements: (jsonData['measurements'] as List<dynamic>? ?? [])
  //           .map((item) => (item is Map<String, dynamic>)
  //               ? item.map(
  //                   (key, value) => MapEntry(key.toString(), value.toString()))
  //               : {"time": "N/A", "description": "Invalid entry"})
  //           .toList(),
  //       proceduresPerformed:
  //           (jsonData['proceduresPerformed'] as List<dynamic>? ?? [])
  //               .map((item) => (item is Map<String, dynamic>)
  //                   ? item.map((key, value) =>
  //                       MapEntry(key.toString(), value.toString()))
  //                   : {"time": "N/A", "description": "Invalid entry"})
  //               .toList(),
  //       medications: (jsonData['medications'] as List<dynamic>? ?? [])
  //           .map((item) => (item is Map<String, dynamic>)
  //               ? item.map(
  //                   (key, value) => MapEntry(key.toString(), value.toString()))
  //               : {"time": "N/A", "description": "Invalid entry"})
  //           .toList(),
  //       evacuationType: jsonData['evacuationType'] ?? "N/A",
  //       evacuationDestination: jsonData['evacuationDestination'] ?? "N/A",
  //       hospitalName: jsonData['hospitalName'] ?? "N/A",
  //       department: jsonData['department'] ?? "N/A",
  //       receivingPersonName: jsonData['receivingPersonName'] ?? "N/A",
  //     );

  //     // Update UI or state with the loadedPatientData as needed
  //     // Example: print(loadedPatientData.fullName);

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('נתונים נטענו בהצלחה!')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error loading JSON: $e')),
  //     );
  //   }
  // }
}
