import 'package:flutter/material.dart';

class PostEventTab extends StatelessWidget {
  const PostEventTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Form Template'),
              items: const [
                DropdownMenuItem(value: 'incident', child: Text('Incident Report')),
                DropdownMenuItem(value: 'care_summary', child: Text('Patient Care Summary')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Personal Notes',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}
