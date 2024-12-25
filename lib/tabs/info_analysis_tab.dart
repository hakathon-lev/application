import 'package:flutter/material.dart';

class InfoAnalysisTab extends StatefulWidget {
  const InfoAnalysisTab({super.key});

  @override
  _InfoAnalysisTabState createState() => _InfoAnalysisTabState();
}

class _InfoAnalysisTabState extends State<InfoAnalysisTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Transcript Input',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Add analysis logic here
              },
              child: const Text('Analyze Transcript'),
            ),
          ],
        ),
      ),
    );
  }
}
