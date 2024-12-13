import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class InfoAnalysisTab extends StatefulWidget {
  const InfoAnalysisTab({super.key});

  @override
  _InfoAnalysisTabState createState() => _InfoAnalysisTabState();
}

class _InfoAnalysisTabState extends State<InfoAnalysisTab> {
  final TextEditingController _transcriptController = TextEditingController();
  final String _certainInfo = '';
  final String _uncertainInfo = '';

  // Use the recommended initialization
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    // Remove the incorrect parameter
    _recorder = FlutterSoundRecorder();

    try {
      // Request microphone permission
      var micStatus = await Permission.microphone.request();
      if (!micStatus.isGranted) {
        _showPermissionError();
        return;
      }

      // Initialize the recorder
      await _recorder?.openRecorder();

      // Optional: set some recording parameters
      await _recorder
          ?.setSubscriptionDuration(const Duration(milliseconds: 10));
    } catch (e) {
      print('Recorder initialization error: $e');
      _showErrorDialog('Recorder Initialization', e.toString());
    }
  }

  void _showPermissionError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Denied'),
        content:
            const Text('Microphone permission is required to record audio.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings(); // Opens app settings to allow manual permission
            },
            child: const Text('Open Settings'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _recordAudio() async {
    if (_recorder == null) {
      _showErrorDialog('Recorder Error', 'Recorder not initialized');
      return;
    }

    try {
      if (!_isRecording) {
        // Start recording
        final tempDir = await getTemporaryDirectory();
        final path = '${tempDir.path}/audio.wav';

        await _recorder?.startRecorder(toFile: path);
        setState(() {
          _isRecording = true;
        });
      } else {
        // Stop recording
        final path = await _recorder?.stopRecorder();
        setState(() {
          _isRecording = false;
        });

        if (path != null) {
          _sendAudioToServer(File(path));
        }
      }
    } catch (e) {
      print('Recording error: $e');
      _showErrorDialog('Recording Error', e.toString());
    }
  }

  Future<void> _sendAudioToServer(File audioFile) async {
    try {
      final url = Uri.parse('http://127.0.0.1:5000/transcribe');
      final request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('file', audioFile.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await http.Response.fromStream(response);
        final data = responseBody.body;
        setState(() {
          _transcriptController.text = data;
        });
      } else {
        setState(() {
          _transcriptController.text = 'Error: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      _showErrorDialog('Server Communication Error', e.toString());
    }
  }

  @override
  void dispose() {
    _recorder?.closeRecorder();
    _transcriptController.dispose();
    super.dispose();
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
              onPressed: _recordAudio,
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
            ElevatedButton(
              onPressed: () {}, // Analysis logic can be added here
              child: const Text('Analyze Transcript'),
            ),
            const SizedBox(height: 20),
            const Text('Certain Information:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey[200],
              child: Text(_certainInfo),
            ),
            const SizedBox(height: 10),
            const Text('Uncertain Information:',
                style: TextStyle(fontWeight: FontWeight.bold)),
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
