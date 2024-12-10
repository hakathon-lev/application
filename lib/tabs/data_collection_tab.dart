import 'package:flutter/material.dart';

class DataCollectionTab extends StatelessWidget {
  const DataCollectionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Hub-Drive Communication', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(labelText: 'Case Location'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Exit Point'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Case Type'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Timestamp'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            Text('Field Documentation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                labelText: 'Actions and Comments',
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
