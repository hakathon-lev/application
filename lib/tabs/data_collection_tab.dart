import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data_service.dart'; // Import the separated file

class DataCollectionTab extends StatefulWidget {
  const DataCollectionTab({super.key});

  @override
  _DataCollectionTabState createState() => _DataCollectionTabState();
}

class _DataCollectionTabState extends State<DataCollectionTab> {
  String url = 'http://127.0.0.1:5000/analyze';
  String queryResult = 'No data yet';
  final TextEditingController caseLocationController = TextEditingController();
  final TextEditingController exitPointController = TextEditingController();
  final TextEditingController caseTypeController = TextEditingController();
  final TextEditingController timestampController = TextEditingController();
  final TextEditingController actionsController = TextEditingController();
  Timer? timer; // Timer for periodic updates

  @override
  void initState() {
    super.initState();
    _updateTimestamp();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _updateTimestamp();
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _updateTimestamp() {
    final now = DateTime.now();
    final formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    setState(() {
      timestampController.text = formattedTimestamp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Hub-Drive Communication',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: caseLocationController,
              decoration: const InputDecoration(labelText: 'Case Location'),
            ),
            TextField(
              controller: exitPointController,
              decoration: const InputDecoration(labelText: 'Exit Point'),
            ),
            TextField(
              controller: caseTypeController,
              decoration: const InputDecoration(labelText: 'Case Type'),
            ),
            TextField(
              controller: timestampController,
              readOnly: true, // Make the field read-only
              decoration: const InputDecoration(labelText: 'Timestamp'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Anamnesis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: actionsController,
              decoration: const InputDecoration(
                labelText: 'Actions and Comments',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final data = {
                  'caseLocation': caseLocationController.text,
                  'exitPoint': exitPointController.text,
                  'caseType': caseTypeController.text,
                  'timestamp': timestampController.text,
                  'actions': actionsController.text,
                };
                final result = await sendData(data, url);
                setState(() {
                  queryResult = result;
                });
              },
              child: const Text('Submit Data'),
            ),
            const SizedBox(height: 20),
            Text(
              'Response: $queryResult',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
