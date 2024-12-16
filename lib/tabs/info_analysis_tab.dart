import 'package:flutter/material.dart';
import 'package:record/record.dart';

class InfoAnalysisTab extends StatefulWidget {
  const InfoAnalysisTab({super.key});

  @override
  _InfoAnalysisTabState createState() => _InfoAnalysisTabState();
}

class _InfoAnalysisTabState extends State<InfoAnalysisTab> {
  late Record audioRecord;
  bool isRecording = false;
  String audioPath = '';
  int number = 0;

  @override
  void initState() {
    audioRecord = Record();
    super.initState();
  }

  @override
  void dispose() {
    audioRecord.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        // Specify the file path and format
        String filePath = './assets/audio ${number++}.mp3';

        number = number + 1;

        await audioRecord.start(
          path: filePath, // Specify the path where the file will be saved
          encoder: AudioEncoder.aacLc, // Use AAC codec (compatible with MP4)
          bitRate: 128000, // Optional: Set a bit rate
          samplingRate: 44100, // Optional: Set a sampling rate
        );

        setState(() {
          isRecording = true;
          audioPath = filePath; // Save the path for later use
        });
      }
    } catch (e) {
      print('Error starting recording : $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        isRecording = false;
        audioPath = path!;
      });
    } catch (e) {
      print('Error starting recording : $e');
    }
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
              decoration: const InputDecoration(
                labelText: 'Transcript Input',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: isRecording ? stopRecording : startRecording,
              child: Text(isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
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
