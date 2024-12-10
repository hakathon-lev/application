import 'package:flutter/material.dart';

class InfoAnalysisTab extends StatefulWidget {
  const InfoAnalysisTab({super.key});

  @override
  _InfoAnalysisTabState createState() => _InfoAnalysisTabState();
}

class _InfoAnalysisTabState extends State<InfoAnalysisTab> {
  final TextEditingController _transcriptController = TextEditingController();
  String _certainInfo = '';
  String _uncertainInfo = '';

  void _analyzeTranscript() {
    setState(() {
      _certainInfo = 'Certain information will be displayed here';
      _uncertainInfo = 'Uncertain information will be displayed here';
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
            TextField(
              controller: _transcriptController,
              decoration: const InputDecoration(
                labelText: 'Transcript Input',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            ElevatedButton(
              onPressed: _analyzeTranscript,
              child: const Text('Analyze Transcript'),
            ),
            const SizedBox(height: 20),
            const Text('Certain Information:', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey[200],
              child: Text(_certainInfo),
            ),
            const SizedBox(height: 10),
            const Text('Uncertain Information:', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey[200],
              child: Text(_uncertainInfo),
            ),
          ],
        ),
      ),
    );
  }
}
