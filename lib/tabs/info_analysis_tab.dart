import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'dart:async';

class InfoAnalysisTab extends StatefulWidget {
  const InfoAnalysisTab({super.key});

  @override
  _AudioStreamManagerState createState() => _AudioStreamManagerState();
}

class _AudioStreamManagerState extends State<InfoAnalysisTab> {
  bool _isRecording = false;
  Stream<List<int>>? _micStream;
  StreamSubscription? _audioSubscription;
  Timer? _debounceTimer;

  Future<void> _startAudioCapture() async {
    var status = await Permission.microphone.request();

    if (status.isGranted) {
      try {
        _micStream = await MicStream.microphone(
          audioSource: AudioSource.MIC,
          sampleRate: 44100,
        );

        setState(() {
          _isRecording = true;
        });

        _audioSubscription = _micStream?.listen((audioChunk) {
          // Debounce to prevent overwhelming the backend
          _debounceTimer?.cancel();
          _debounceTimer = Timer(const Duration(milliseconds: 100), () {
            _sendAudioToBackend(audioChunk);
          });
        }, onError: (error) {
          print('Audio capture error: $error');
          _stopAudioCapture();
        });
      } catch (e) {
        print('Failed to start audio capture: $e');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to start audio capture: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission denied')));
    }
  }

  Future<void> _sendAudioToBackend(List<int> audioChunk) async {
    try {
      // Base64 encode to send as JSON
      String encodedAudio = base64Encode(audioChunk);

      final response = await http.post(Uri.parse('http://localhost:5000/audio'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'audio': encodedAudio,
            'timestamp': DateTime.now().millisecondsSinceEpoch
          }));

      if (response.statusCode != 200) {
        print('Backend response error: ${response.body}');
      }
    } catch (e) {
      print('Failed to send audio chunk: $e');
    }
  }

  void _stopAudioCapture() {
    _audioSubscription?.cancel();
    _micStream = null;
    _debounceTimer?.cancel();

    setState(() {
      _isRecording = false;
    });
  }

  @override
  void dispose() {
    _stopAudioCapture();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _isRecording ? _stopAudioCapture : _startAudioCapture,
          child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
        ),
      ),
    );
  }
}
