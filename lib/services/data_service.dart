import 'dart:convert';
import 'package:http/http.dart' as http;

/// Sends data to the server and returns the response message.
Future<String> sendData(Map<String, String> data, String url) async {
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['message'] ?? 'No message received';
    } else {
      return 'Error: ${response.statusCode}';
    }
  } catch (e) {
    return 'An error occurred: $e';
  }
}
