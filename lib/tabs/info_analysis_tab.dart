import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:intl/intl.dart';
import 'dart:async'; // For Timer
import 'dart:io'; // For File
import 'package:http/http.dart' as http; // For HTTP requests

class InfoAnalysisTab extends StatefulWidget {
  const InfoAnalysisTab({super.key});

  @override
  _InfoAnalysisTabState createState() => _InfoAnalysisTabState();
}

class _InfoAnalysisTabState extends State<InfoAnalysisTab> {
  late Record audioRecord;
  bool isRecording = false;
  String audioPath = '';
  Timer? recordingTimer;

  final String serverUrl =
      'https://yourserver.com/upload'; // Replace with your server URL

  @override
  void initState() {
    audioRecord = Record();
    super.initState();
  }

  @override
  void dispose() {
    recordingTimer?.cancel();
    audioRecord.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        // Function to start a new recording
        await _startNewRecording();

        // Start a timer to stop and start a new recording every 30 seconds
        recordingTimer = Timer.periodic(Duration(seconds: 30), (timer) async {
          await _restartRecording();
        });

        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      recordingTimer?.cancel(); // Stop the timer
      String? path = await audioRecord.stop();
      if (path != null) {
        await sendFileToServer(File(path));
      }
      setState(() {
        isRecording = false;
        audioPath = path ?? '';
      });
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> _startNewRecording() async {
    try {
      // Generate a timestamp-based file name
      String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      String filePath = './assets/audio_$timestamp.mp3';

      await audioRecord.start(
        path: filePath,
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        samplingRate: 44100,
      );

      setState(() {
        audioPath = filePath;
      });
    } catch (e) {
      print('Error starting new recording: $e');
    }
  }

  Future<void> _restartRecording() async {
    try {
      // Stop the current recording
      String? path = await audioRecord.stop();

      // Send the file to the server
      if (path != null) {
        await sendFileToServer(File(path));
      }

      // Start a new recording
      await _startNewRecording();
    } catch (e) {
      print('Error restarting recording: $e');
    }
  }

  Future<void> sendFileToServer(File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(serverUrl));
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        print('File uploaded successfully: ${file.path}');
      } else {
        print('Failed to upload file: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading file: $e');
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
            const TextField(
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
