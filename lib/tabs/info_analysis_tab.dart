import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'dart:async';

class InfoAnalysisTab extends StatefulWidget {
  const InfoAnalysisTab({super.key});

  @override
  _InfoAnalysisTabState createState() => _InfoAnalysisTabState();
}

class _InfoAnalysisTabState extends State<InfoAnalysisTab> {
  bool _isRecording = false;
  Stream<List<int>>? _micStream;
  StreamSubscription? _audioSubscription;
  Timer? _debounceTimer;
  bool _isDisposed = false;

  Future<void> _startAudioCapture() async {
    var status = await Permission.microphone.request();
    if (!status.isGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission denied')),
        );
      }
      return;
    }

    try {
      _micStream = await MicStream.microphone(
        audioSource: AudioSource.MIC,
        sampleRate: 44100,
      );

      if (_isDisposed) return;

      setState(() {
        _isRecording = true;
      });

      _audioSubscription = _micStream?.listen((audioChunk) {
        _debounceTimer?.cancel();
        _debounceTimer = Timer(const Duration(milliseconds: 100), () {
          _sendAudioToBackend(audioChunk);
        });
      }, onError: (error) {
        if (!_isDisposed) {
          print('Audio capture error: $error');
          _stopAudioCapture();
        }
      });
    } catch (e) {
      if (!_isDisposed) {
        print('Failed to start audio capture: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to start audio capture: $e')),
          );
        }
      }
    }
  }

  Future<void> _sendAudioToBackend(List<int> audioChunk) async {
    try {
      String encodedAudio = base64Encode(audioChunk);

      final response = await http.post(
        Uri.parse('http://192.168.1.100:5000/audio'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'audio': encodedAudio,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        }),
      );

      if (response.statusCode != 200) {
        print('Backend error: ${response.body}');
      }
    } catch (e) {
      print('Failed to send audio chunk: $e');
    }
  }

  void _stopAudioCapture() {
    _audioSubscription?.cancel();
    _audioSubscription = null;

    _debounceTimer?.cancel();
    _debounceTimer = null;

    if (!_isDisposed) {
      setState(() {
        _isRecording = false;
      });
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
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
