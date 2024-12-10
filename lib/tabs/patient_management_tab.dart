import 'package:flutter/material.dart';

class PatientManagementTab extends StatelessWidget {
  const PatientManagementTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Patient Name'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Patient ID'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Date of Birth'),
              keyboardType: TextInputType.datetime,
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Medical Condition'),
              items: const [
                DropdownMenuItem(value: 'trauma', child: Text('Trauma')),
                DropdownMenuItem(value: 'critical', child: Text('Critical')),
              ],
              onChanged: (value) {},
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Compare with Database'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Edit and Sign Form'),
            ),
          ],
        ),
      ),
    );
  }
}
